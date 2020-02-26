#!/bin/bash
nohup $@ >/dev/null 2>&1;
while sleep 60; do
  echo `date`;
done