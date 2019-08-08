#!/bin/bash
nohup $@ >/dev/null 2>&1;
while sleep 5; do
  echo `date`;
done