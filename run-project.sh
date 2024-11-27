#!/bin/bash

# Path directory submodul
TASK_TRACKER_BACKEND_PATH="./task-tracker-backend"
TASK_TRACKER_FRONTEND_PATH="./task-tracker-frontend"

# check the pm2 instalation
if ! command -v pm2 &> /dev/null
then
    echo "PM2 not found, installing PM2 globally..."
    npm install -g pm2
else
    echo "PM2 is already installed."
fi

# check the go instalation
if ! command -v go &> /dev/null
then
    echo "Go not found, please install Go first."
    exit 1
else
    echo "Go is installed."
fi

# check the pnpm instalation
if ! command -v pnpm &> /dev/null
then
    echo "pnpm not found, installing pnpm globally..."
    npm install -g pnpm
else
    echo "pnpm is already installed."
fi

# running pm2
pm2 start "go run main.go" --name "task-tracker-backend" --watch --cwd $TASK_TRACKER_BACKEND_PATH

pm2 start "pnpm run dev" --name "task-tracker-frontend" --cwd $TASK_TRACKER_FRONTEND_PATH

echo "Both Backend and Frontend are running under PM2."
echo "Use 'pm2 list' to view processes."
echo "Use 'pm2 stop <app-name>' to stop a process."
echo "For more details check https://pm2.keymetrics.io/"
