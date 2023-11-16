#set env vars
set -o allexport; source .env; set +o allexport;

cat << EOT >> ./.env

PWP__MAIL__MAILER_SENDER='"Password Pusher" <link-u353.vm.elestio.app@vm.elestio.app>'
EOT
