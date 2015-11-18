echo running tests for wordpress
UUID=$(cat /proc/sys/kernel/random/uuid)

pass "unable to start the $VERSION container" docker run --privileged=true -d --name $UUID nanobox/build-wordpress sleep 365d

defer docker kill $UUID

pass "unable to create code folder" docker exec $UUID mkdir -p /opt/code

fail "Detected something when there shouldn't be anything" docker exec $UUID bash -c "cd /opt/engines/wordpress/bin; ./sniff /opt/code"

pass "Failed to inject wordpress file" docker exec $UUID mkdir -p /opt/code/wp-content

pass "Failed to detect WordPress" docker exec $UUID bash -c "cd /opt/engines/wordpress/bin; ./sniff /opt/code"