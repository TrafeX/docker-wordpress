#!/usr/bin/env sh
apk --no-cache add curl
while ! curl -fs wordpress > /dev/null; do echo -n '.'; sleep 1; done;
curl --silent --fail http://wordpress/wp-admin/install.php | grep 'wp-core-ui' > /dev/null
