<a href="https://elest.io">
  <img src="https://elest.io/images/elestio.svg" alt="elest.io" width="150" height="75">
</a>

[![Discord](https://img.shields.io/static/v1.svg?logo=discord&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=Discord&message=community)](https://discord.gg/4T4JGaMYrD "Get instant assistance and engage in live discussions with both the community and team through our chat feature.")
[![Elestio examples](https://img.shields.io/static/v1.svg?logo=github&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=github&message=open%20source)](https://github.com/elestio-examples "Access the source code for all our repositories by viewing them.")
[![Blog](https://img.shields.io/static/v1.svg?color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=elest.io&message=Blog)](https://blog.elest.io "Latest news about elestio, open source software, and DevOps techniques.")

# Password Pusher, verified and packaged by Elestio

[Password Pusher](https://github.com/pglombardo/PasswordPusher) is an opensource application to communicate passwords over the web. Links to passwords expire after a certain number of views and/or time has passed.

<img src="https://github.com/elestio-examples/password-pusher/raw/main/password-pusher.png" alt="password-pusher" width="800">

[![deploy](https://github.com/elestio-examples/password-pusher/raw/main/deploy-on-elestio.png)](https://dash.elest.io/deploy?source=cicd&social=dockerCompose&url=https://github.com/elestio-examples/password-pusher)

Deploy a <a target="_blank" href="https://elest.io/open-source/password-pusher">fully managed Password Pusher</a> on <a target="_blank" href="https://elest.io/">elest.io</a> if you want a free and open-source, decentralized, ActivityPub federated video platform powered by WebTorrent, that uses peer-to-peer technology to reduce load on individual servers when viewing videos.

# Why use Elestio images?

- Elestio stays in sync with updates from the original source and quickly releases new versions of this image through our automated processes.
- Elestio images provide timely access to the most recent bug fixes and features.
- Our team performs quality control checks to ensure the products we release meet our high standards.

# Usage

## Git clone

You can deploy it easily with the following command:

    git clone https://github.com/elestio-examples/password-pusher.git

Copy the .env file from tests folder to the project directory

    cp ./tests/.env ./.env

Edit the .env file with your own values.

Create data folders with correct permissions

    set -o allexport; source .env; set +o allexport;

    mkdir -p ./storage
    chown -R 1000:1000 ./storage

    cat << EOT >> ./.env

    PWP__MAIL__MAILER_SENDER='"Password Pusher" <link-u353.vm.elestio.app@vm.elestio.app>'
    EOT

Run the project with the following command

    docker-compose up -d

You can access the Web UI at: `http://your-domain:33140`

## Docker-compose

Here are some example snippets to help you get started creating a container.

    version: "3.3"
    services:
      db:
        image: elestio/mysql:8.0
        restart: always
        ports:
          - "172.17.0.1:50632:3306"
        environment:
          - MYSQL_USER=pwpush
          - MYSQL_PASSWORD=${MYSQL_PASSWORD}
          - MYSQL_DATABASE=pwpush
          - MYSQL_ROOT_PASSWORD=${MYSQL_PASSWORD}
        volumes:
          - ./mysql:/var/lib/mysql

      pwpush:
        image: eleastio4test/pwpush:latest
        restart: always
        ports:
          - "172.17.0.1:33140:5100"
        env_file:
          - ./.env
        depends_on:
          - db
        links:
          - db:mysql
        volumes:
          - ./storage:/opt/PasswordPusher/storage

      pma:
        image: elestio/phpmyadmin:latest
        restart: always
        links:
          - db:db
        ports:
          - "172.17.0.1:5965:80"
        environment:
          PMA_HOST: db
          PMA_PORT: 3306
          PMA_USER: pwpush
          PMA_PASSWORD: ${MYSQL_PASSWORD}
          UPLOAD_LIMIT: 500M
          MYSQL_USERNAME: pwpush
          MYSQL_ROOT_PASSWORD: ${MYSQL_PASSWORD}
        depends_on:
          - db

### Environment variables

|       Variable       |     Value (example)     |
| :------------------: | :---------------------: |
|       MYSQL_USER     |  database username      |
|     MYSQL_PASSWORD   |  database password      |
|     MYSQL_DATABASE   |  database name          |
|  MYSQL_ROOT_PASSWORD |  database root password |
|       PMA_HOST       |  database hostname      |
|       PMA_PORT       |  database port          |
|     PMA_PASSWORD     |  database password      |
|     UPLOAD_LIMIT     |  import file size limit |

# Maintenance

## Logging

The Elestio Password-Pusher Docker image sends the container logs to stdout. To view the logs, you can use the following command:

    docker-compose logs -f

To stop the stack you can use the following command:

    docker-compose down

## Backup and Restore with Docker Compose

To make backup and restore operations easier, we are using folder volume mounts. You can simply stop your stack with docker-compose down, then backup all the files and subfolders in the folder near the docker-compose.yml file.

Creating a ZIP Archive
For example, if you want to create a ZIP archive, navigate to the folder where you have your docker-compose.yml file and use this command:

    zip -r myarchive.zip .

Restoring from ZIP Archive
To restore from a ZIP archive, unzip the archive into the original folder using the following command:

    unzip myarchive.zip -d /path/to/original/folder

Starting Your Stack
Once your backup is complete, you can start your stack again with the following command:

    docker-compose up -d

That's it! With these simple steps, you can easily backup and restore your data volumes using Docker Compose.

# Links

- <a target="_blank" href="https://github.com/pglombardo/PasswordPusher/wiki">Password Pusher documentation</a>

- <a target="_blank" href="https://github.com/pglombardo/PasswordPusher">Password Pusher Github repository</a>

- <a target="_blank" href="https://github.com/elestio-examples/password-pusher">Elestio/password-pusher Github repository</a>
