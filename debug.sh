#!/usr/bin/env bash

docker compose -f docker-compose.local.yaml down

./microservices/api-gateway/gradlew -p ./microservices/api-gateway/ clean assemble
./microservices/authorization-server/gradlew -p ./microservices/authorization-server/ clean assemble
./microservices/user-service/gradlew -p ./microservices/user-service/ clean assemble

docker compose -f docker-compose.local.yaml up --build
