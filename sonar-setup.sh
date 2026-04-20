#!/bin/bash
set -a
source "$(dirname "$0")/.env"
set +a

SONAR_URL="http://localhost:9000"
SONAR_TOKEN="${SONAR_TOKEN}"

# Crear proyecto backend
curl -u $SONAR_TOKEN: -X POST \
  "$SONAR_URL/api/projects/create" \
  -d "name=lyhost-backend&project=lyhost-backend"

# Crear proyecto frontend
curl -u $SONAR_TOKEN: -X POST \
  "$SONAR_URL/api/projects/create" \
  -d "name=lyhost-frontend&project=lyhost-frontend"

# Crear webhook para Jenkins
curl -u $SONAR_TOKEN: -X POST \
  "$SONAR_URL/api/webhooks/create" \
  -d "name=Jenkins&url=http://Jenkins:8080/sonarqube-webhook/"

echo "SonarQube configured!"