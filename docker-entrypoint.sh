#!/bin/bash

$neighbors
for buddy in $(cat /iri/conf/neighbors); do
  neighbors="$buddy $neighbors"
done
neighbors=${neighbors::-1}

if [[ $REVALIDATE == "false" ]]; then : ; else v="--revalidate"; fi

p="${API_PORT:-14265}"
u="${UDP_PORT:-14600}"
t="${TCP_PORT:-15600}"

exec java --add-modules java.xml.bind -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:+DisableAttachMechanism -Xms$MIN_MEMORY -Xmx$MAX_MEMORY -Dlogback.configurationFile=/iri/conf/logback.xml -Djava.net.preferIPv4Stack=true -jar /iri/target/iri*.jar --config /iri/conf/iri.ini --port $p --udp-receiver-port $u --tcp-receiver-port $t --neighbors "$neighbors" $v --remote --remote-limit-api "$REMOTE_API_LIMIT" "$@"
