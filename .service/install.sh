#!/bin/bash

SERVICE_NAME="pyracer-srv.service"
TEMPLATE_PATH="./$SERVICE_NAME"
DESTINATION_PATH="/etc/systemd/system/$SERVICE_NAME"
APP_PATH="/home/massimo/apps/pyracer-srv"

# Copy all files to the app folder
echo "Copy all files to the app folder."
mkdir -p $APP_PATH
rsync -a ../ $APP_PATH

# Stop the service
if systemctl is-active --quiet $SERVICE_NAME; then
	echo "Stop service $SERVICE_NAME"
	sudo systemctl stop $SERVICE_NAME
fi

# Install the service
if systemctl list-unit-files | grep -qw $SERVICE_NAME; then
	echo "Service $SERVICE_NAME is already installed."
else
	if [ ! -f "$TEMPLATE_PATH" ]; then
		echo "ERROR! $TEMPLATE_PATH does not exist"
		exit 1
	fi

	if [ ! -f "$DESTINATION_PATH" ]; then
		echo "Copy $SERVICE_NAME to $DESTINATION_PATH."
		sudo cp "$TEMPLATE_PATH" "$DESTINATION_PATH"
	fi

	# Installa il servizio
	echo "Install service $SERVICE_NAME."
	sudo systemctl daemon-reload
	sudo systemctl enable $SERVICE_NAME
fi

# Daemon reload
echo "Daemon reload"
sudo systemctl daemon-reload

# Start the service
echo "Start service $SERVICE_NAME"
sudo systemctl start $SERVICE_NAME

echo "Done."