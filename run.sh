#!/usr/bin/env bash

./microservices/api-gateway/gradlew -p ./microservices/api-gateway/ clean assemble
./microservices/authorization-server/gradlew -p ./microservices/authorization-server/ clean assemble
./microservices/user-service/gradlew -p ./microservices/user-service/ clean assemble

docker-compose -f docker-compose.yaml up --build --detach

read -r -p "Microservices have started. Do you want to open the app in Firefox? [y/N] " user_decision

if [[ $user_decision =~ ^[Yy]$ ]]; then
  firefox http://localhost
else
  echo "Not opening the app in Firefox."
fi
