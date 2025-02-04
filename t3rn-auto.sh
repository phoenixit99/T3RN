#!/bin/bash
echo "                                                                    "
echo "                                                                    "
echo "                                                                    "
echo "                                                                    "
echo "  H   H  EEEEE  N   N  RRRR   Y    Y     N   N  OOO   DDDD   EEEEE  "
echo "  H   H  E      NN  N  R   R    Y Y      NN  N O   O  D   D  E      "
echo "  HHHHH  EEEE   N N N  RRRR      Y       N N N O   O  D   D  EEEE   "
echo "  H   H  E      N  NN  R  R      Y       N  NN O   O  D   D  E      "
echo "  H   H  EEEEE  N   N  R   R     Y       N   N  OOO   DDDD   EEEEE  "
echo "                                                                    "
echo "                                                                    "
echo "                                                                    "
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
wget https://github.com/t3rn/executor-release/releases/download/v0.48.0/executor-linux-v0.48.0.tar.gz
tar -xf executor-linux-v0.48.0.tar.gz

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
Environment="EXECUTOR_PROCESS_BIDS_ENABLED=true"
Environment="EXECUTOR_PROCESS_ORDERS_ENABLED=true"
Environment="EXECUTOR_PROCESS_CLAIMS_ENABLED=true"
Environment="ENABLED_NETWORKS=arbitrum-sepolia,blast-sepolia,base-sepolia,optimism-sepolia,l1rn"
Environment="RPC_ENDPOINTS_BSSP=https://sepolia.base.org"
Environment="RPC_ENDPOINTS_BLSS=https://sepolia.blast.io"
Environment="RPC_ENDPOINTS_ARBT=https://arbitrum-sepolia-rpc.publicnode.com,https://sepolia-rollup.arbitrum.io/rpc"
Environment="RPC_ENDPOINTS_OPSP=https://optimism-sepolia.drpc.org"

[Install]                     
WantedBy=multi-user.target   
EOF

sudo systemctl daemon-reload
sudo systemctl enable t3rnd
sudo systemctl restart t3rnd
sudo journalctl -u t3rnd -f -o cat

echo "Version 0.27.0"
echo "Check log: sudo journalctl -u t3rnd -f -o cat"
echo "Restart: sudo systemctl restart t3rnd"
echo "Stop: sudo systemctl stop t3rnd"
echo "Script completed successfully."
echo "exit 5s"
sleep 5
