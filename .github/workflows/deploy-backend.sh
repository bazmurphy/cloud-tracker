#!/bin/sh
DB_CONNECTION_STRING="$1"
DB_SSL="$2"
echo "Attempting Deploy..." &&
pm2 list | grep -q "cloud-tracker-api" && pm2 delete all || true &&
rm -rf cloud-tracker &&
cp -r backend cloud-tracker &&
cd backend &&
pm2 start "cloud-tracker/backend/dist/index.js" --name cloud-tracker-api &&
echo "Deploy Complete!"