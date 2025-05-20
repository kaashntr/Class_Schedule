#!/bin/bash

FILE=$1

if [ -z "$API_HOST" ]; then
  echo "API_HOST is not set"
  exit 1
fi

sed -i "s|http://localhost:8080/|http://$API_HOST:8080/|g" "$FILE"
