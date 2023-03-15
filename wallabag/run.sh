#!/bin/sh
# Exit when any command fails
set -e

COMMAND_ARG1="$1"
COMMAND_ARG2="$2"

cd /var/www/wallabag || exit

wait_for_database() {
    timeout 60s /bin/sh -c "$(cat << EOF
        until echo 'Waiting for database ...' \
            && nc -z ${SYMFONY__ENV__DATABASE_HOST} ${SYMFONY__ENV__DATABASE_PORT} < /dev/null > /dev/null 2>&1 ; \
        do sleep 1 ; done
EOF
)"
}

install_wallabag() {
    su -c "php bin/console wallabag:install --env=prod -n" -s /bin/sh nobody
}

provisioner() {
    SYMFONY__ENV__DATABASE_DRIVER=${SYMFONY__ENV__DATABASE_DRIVER:-pdo_sqlite}
    POPULATE_DATABASE=${POPULATE_DATABASE:-True}

    # Replace environment variables
    envsubst < /etc/wallabag/parameters.template.yml > app/config/parameters.yml

    # Wait for external database
        wait_for_database

    # Configure SQLite database
    if [ ! -f "/var/www/wallabag/data/db/wallabag.sqlite" ] ; then
        echo "Configuring the SQLite database ..."
        install_wallabag
    fi

    # Remove cache and install Wallabag
    rm -f -r /var/www/wallabag/var/cache
    su -c "SYMFONY_ENV=prod composer install --no-dev -o --prefer-dist" -s /bin/sh nobody
}

if [ "$COMMAND_ARG1" = "wallabag" ]; then
    echo "Starting Wallabag ..."
    provisioner
    echo "Wallabag is ready!"
    exec s6-svscan /etc/s6/
fi

if [ "$COMMAND_ARG1" = "import" ]; then
    provisioner
    exec su -c "bin/console wallabag:import:redis-worker --env=prod $COMMAND_ARG2 -vv" -s /bin/sh nobody
fi

if [ "$COMMAND_ARG1" = "migrate" ]; then
    provisioner
    exec su -c "bin/console doctrine:migrations:migrate --env=prod --no-interaction" -s /bin/sh nobody
fi

exec "$@"
wallabag
