1. Create a Systemd Service Unit:
   `sudo nano /etc/systemd/system/cloud-tracker-docker-compose.service`

2. Add Configuration to the Service Unit File:

   ```ini
   [Unit]
   Description=Cloud Tracker Docker Compose
   After=docker.service network-online.target
   Wants=docker.service

   [Service]
   Restart=always
   WorkingDirectory=/home/ec2-user
   ExecStart=/usr/local/bin/docker-compose up -d
   ExecStop=/usr/local/bin/docker-compose down

   [Install]
   WantedBy=multi-user.target
   ```

3. Reload the Service Daemon:
   `sudo systemctl daemon-reload`

4. Enable the Service:
   `sudo systemctl enable cloud-tracker-docker-compose`

5. Start the Service:  
   `sudo systemctl start cloud-tracker-docker-compose`

6. Reboot and Test It:
   Check Service Status: `systemctl status cloud-tracker-docker-compose`
   Check Service is Active: `systemctl is-active cloud-tracker-docker-compose`
   Check Service Logs: `journalctl -u cloud-tracker-docker-compose`

7. Delete It All:
   `sudo systemctl disable cloud-tracker-docker-compose`
   `sudo systemctl stop cloud-tracker-docker-compose`
   `sudo rm /etc/systemd/system/cloud-tracker-docker-compose.service`
   `sudo systemctl daemon-reload`

8. CUSTOM BASH SCRIPT TO DO THE ABOVE

   ```bash
   #!/bin/bash

   # Define the service name and path to your docker-compose.yml file
   SERVICE_NAME="cloud-tracker-docker-compose"
   COMPOSE_PATH="/home/ec2-user"

   # Create the systemd service unit file
   cat <<EOF > /etc/systemd/system/$SERVICE_NAME.service
   [Unit]
   Description=Cloud Tracker Docker Compose
   After=docker.service network-online.target
   Wants=docker.service

   [Service]
   Restart=always
   WorkingDirectory=$COMPOSE_PATH
   ExecStart=/usr/local/bin/docker-compose up -d
   ExecStop=/usr/local/bin/docker-compose down

   [Install]
   WantedBy=multi-user.target
   EOF

   # Reload systemd and enable the service
   systemctl daemon-reload
   systemctl enable $SERVICE_NAME

   # Start the service
   systemctl start $SERVICE_NAME

   echo "Cloud Tracker Docker Compose service '$SERVICE_NAME' has been configured and started."
   ```

---

1. `sudo nano /etc/systemd/system/cloud-tracker-docker-compose.service`

2. ```ini
   [Unit]
   Description=Docker Compose Up Service

   [Service]
   Type=oneshot
   RemainAfterExit=true
   ExecStart=/usr/local/bin/docker-compose -f /home/ec2-user/docker-compose.yml up -d

   [Install]
   WantedBy=multi-user.target
   ```

3. `sudo systemctl daemon-reload`

4. `sudo systemctl enable docker-compose`

5. `sudo systemctl start docker-compose`

6. `sudo reboot`
