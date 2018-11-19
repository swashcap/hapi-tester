#!/bin/bash
set -eo pipefail

. "$NVM_DIR/nvm.sh" # Load nvm

mkdir -p logs

for dir in hapi-16 hapi-17; do
  cd "$dir" && npm install

  for version in 8.12.0 10.13.0 11.2.0; do
    nvm use "$version"
    npm rebuild

    node index.js &
    sleep 1 # Time for server to accept requests

    for i in {1..20}; do
      ab -n 1000 -c 100 http://127.0.0.1:3000/ >> "../logs/$dir-$version.log"
      sleep 1
    done

    kill -9 $! # Kill background server
  done

  cd -
done

