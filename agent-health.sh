#!/bin/bash
PID=$(pgrep Agent.Listener)

if [ -z "$PID" ]
then
  echo "Agent.Listener is not running"
  exit 1
else
  echo "Agent.Listener is running, pid $PID"
  exit 0
fi

