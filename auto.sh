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
# Warning message for enabling networks

echo "                                                                                                                        "
echo "                                                                                                                        "
echo "                                                                                                                        "
echo "                                                                                                                        "
echo "WARNING: Ensure that arbitrum-sepolia, base-sepolia, and optimism-sepolia networks are enabled for proper functionality."
echo "                                                                                                                        "
echo "                                                                                                                        "
echo "                                                                                                                        "
echo "                                                                                                                        "

set -e  # Exit script on error

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
wget https://github.com/t3rn/executor-release/releases/download/v0.21.0/executor-linux-v0.21.0.tar.gz
tar -xf executor-linux-v0.21.0.tar.gz
cd executor/executor/

# Prompt user for private key

read -p "Enter your privateKey (get from your Wallet): " privatekey

# Set environment variables
export NODE_ENV=testnet
export LOG_LEVEL=debug
export LOG_PRETTY=false
export PRIVATE_KEY_LOCAL=$privatekey
export ENABLED_NETWORKS='arbitrum-sepolia,base-sepolia,blast-sepolia,optimism-sepolia,l1rn'


# Run the executor
cd bin
./executor

echo "Script completed successfully."
