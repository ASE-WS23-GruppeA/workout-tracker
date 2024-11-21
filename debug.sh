#!/usr/bin/env bash

docker compose -f docker-compose.local.yaml down

./microservices/api-gateway/gradlew -p ./microservices/api-gateway/ clean assemble || exit
./microservices/authorization-server/gradlew -p ./microservices/authorization-server/ clean assemble || exit
./microservices/user-service/gradlew -p ./microservices/user-service/ clean assemble || exit
./microservices/analytics-service/gradlew -p ./microservices/analytics-service/ clean assemble || exit
./microservices/workout-service-java/gradlew -p ./microservices/workout-service-java/ clean assemble || exit

(
  cd ./microservices/frontend/FE_Fitness_Tracker || exit
  npm install
  npm run build:prod
)

docker compose -f docker-compose.local.yaml up --build
