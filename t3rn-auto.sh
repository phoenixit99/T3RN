#!/bin/bash
echo "
███    ██  ██████  ██████  ███████ ██████   █████     ████████  ██████  ██████  
████   ██ ██    ██ ██   ██ ██           ██ ██   ██       ██    ██    ██ ██   ██ 
██ ██  ██ ██    ██ ██   ██ █████    █████   ██████       ██    ██    ██ ██████  
██  ██ ██ ██    ██ ██   ██ ██           ██      ██       ██    ██    ██ ██      
██   ████  ██████  ██████  ███████ ██████   █████  ██    ██     ██████  ██      "
# Warning message for enabling networks
sleep 3
echo "                                                                                                                        "
echo "                                                                                                                        "
echo "                                                                                                                        "
echo "                                                                                                                        "
echo "WARNING: Ensure that arbitrum-sepolia, base-sepolia, and optimism-sepolia networks are enabled for proper functionality."
echo "                                                                                                                        "
echo "                                                                                                                        "
echo "                                                                                                                        "
echo "                                                                                                                        "
sleep 3
set -e  # Exit script on error
# Detele t3rnd service
sudo systemctl stop t3rnd &&  rm -rf /etc/systemd/system/t3rnd.service && sudo systemctl daemon-reload
rm -rf $HOME/t3rn
# Setup directory and clean up any previous run
cd $HOME

if [ -d "t3rn" ]; then
    echo "Directory 't3rn' exists. Removing it..."
    rm -rf t3rn
fi
# Create and navigate to t3rn directory
mkdir t3rn 
cd t3rn 

# Download and extract executor
wget https://github.com/t3rn/executor-release/releases/download/v0.21.5/executor-linux-v0.21.5.tar.gz
tar -xf executor-linux-v0.21.5.tar.gz

# Prompt user for private key

read -p "Enter your privateKey (get from your Wallet): " privatekey


sudo tee /etc/systemd/system/t3rnd.service > /dev/null <<EOF

[Unit]
Description=Executor T3RN
After=network.target

[Service]
Type=simple
User=root
Group=root
WorkingDirectory=/root/t3rn/executor/executor/bin
ExecStart=/root/t3rn/executor/executor/bin/executor
Restart=always
RestartSec=3
Environment="NODE_ENV=testnet"
Environment="LOG_LEVEL=debug"
Environment="LOG_PRETTY=false"
Environment="PRIVATE_KEY_LOCAL=$privatekey"
Environment="ENABLED_NETWORKS=arbitrum-sepolia,blast-sepolia,base-sepolia,optimism-sepolia,l1rn"

[Install]                     
WantedBy=multi-user.target   
EOF

sudo systemctl daemon-reload
sudo systemctl enable t3rnd
sudo systemctl restart t3rnd
sudo journalctl -u t3rnd -f -o cat

echo "Version 0.21.4"
echo "Check log: sudo journalctl -u t3rnd -f -o cat"
echo "Restart: sudo systemctl restart t3rnd"
echo "Stop: sudo systemctl stop t3rnd"
echo "Script completed successfully."
echo "exit 5s"
sleep 5
