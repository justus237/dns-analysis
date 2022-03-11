#!/bin/bash

declare -a vantagepoints=("useast" "uswest" "afsouth" "apnorth" "apsouth" "eucentral" "saeast")

for vp in "${vantagepoints[@]}"
do
	scp "doqmsm-${vp}:/home/ubuntu/web-performance-youtube/web-performance-youtube.db" "web-performance-youtube-${vp}.db" &
done
wait
echo "copying done"
echo "running sqlite recover over all databases in case they were copied in the middle of a measurement run"
for vp in "${vantagepoints[@]}"
do
	sqlite3 "web-performance-youtube-${vp}.db" ".recover" | sqlite3 "web-performance-youtube-${vp}-n.db"
	rm "web-performance-youtube-${vp}.db"
	mv "web-performance-youtube-${vp}-n.db" "web-performance-youtube-${vp}.db"
done
echo "sqlite done"
