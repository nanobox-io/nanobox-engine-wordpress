echo running tests for wordpress
UUID=$(cat /proc/sys/kernel/random/uuid)

pass "unable to start the $VERSION container" docker run --privileged=true -d --name $UUID nanobox/build-wordpress sleep 365d

defer docker kill $UUID

pass "unable to create code folder" docker exec $UUID mkdir -p /opt/code

fail "Detected something when there shouldn't be anything" docker exec $UUID bash -c "cd /opt/engines/wordpress/bin; ./sniff /opt/code"

pass "Failed to inject wordpress file" docker exec $UUID touch /opt/code/wp-login.php

pass "Failed to detect PHP" docker exec $UUID bash -c "cd /opt/engines/wordpress/bin; ./sniff /opt/code"