#set env vars
set -o allexport; source .env; set +o allexport;

mkdir -p ./storage
chown -R 1000:1000 ./storage

cat << EOT >> ./.env

PWP__MAIL__MAILER_SENDER='"Password Pusher" <link-u353.vm.elestio.app@vm.elestio.app>'
EOT
