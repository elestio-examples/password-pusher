#set env vars
set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for software to be ready ..."
sleep 60s;

docker-compose exec -T pwpush bash -c "cd /opt/PasswordPusher/bin && ./rails runner 'User.create(email:\"${ADMIN_EMAIL}\", admin:true, password:\"${ADMIN_PASSWORD}\")'"
