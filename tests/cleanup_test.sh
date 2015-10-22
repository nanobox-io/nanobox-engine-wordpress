echo running tests for wordpress
UUID=$(cat /proc/sys/kernel/random/uuid)

pass "unable to start the $VERSION container" docker run --privileged=true -d --name $UUID nanobox/build-wordpress sleep 365d

defer docker kill $UUID

pass "Failed to run cleanup script" docker exec $UUID bash -c "cd /opt/engines/wordpress/bin; ./cleanup '$(payload default-cleanup)'"