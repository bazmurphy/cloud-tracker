#!/bin/sh
DB_CONNECTION_STRING="$1"
DB_SSL="$2"
echo "Attempting Deploy..." &&
pm2 list | grep -q "cloudtrackerapi" && pm2 delete all || true &&
rm -rf cloudtracker &&
cp -r backend cloudtracker &&
cd backend &&
pm2 start "cloudtracker/backend/dist/index.js" --name cloudtrackerapi &&
echo "Deploy Complete!"