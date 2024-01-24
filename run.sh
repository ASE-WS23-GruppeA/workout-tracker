#!/usr/bin/env bash

docker compose -f docker-compose.local.yaml down

./microservices/api-gateway/gradlew -p ./microservices/api-gateway/ clean assemble
./microservices/authorization-server/gradlew -p ./microservices/authorization-server/ clean assemble
./microservices/user-service/gradlew -p ./microservices/user-service/ clean assemble
./microservices/analytics-service/gradlew -p ./microservices/user-service/ clean assemble

(
  cd ./microservices/frontend/FE_Fitness_Tracker || exit
  npm install
  npm run build:prod
)

docker compose -f docker-compose.local.yaml up --build --detach
