#!/bin/bash
chmod -R 777 /root/.*
nohup $@ > /dev/null 2>&1;
while sleep 60; do
  echo `date`;
done