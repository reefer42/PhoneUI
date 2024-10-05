#!/bin/bash

# Function to display the options menu

show_menu() {

echo "Options:"

echo "1. Install Stable Diffusion"

echo "2. Install Ollama"

echo "3. Exit"

read -p "Enter your choice: " choice

}

# Function to install Stable Diffusion

install_stable_diffusion() {

# Update and upgrade system packages

apt update && apt full-upgrade -y

sudo apt install -y build-essential cmake python3.11-venv python3-pip python3-setuptools

# Make the "wui" directory and navigate to it

mkdir -p wui && cd wui

# Create the virtual environment using Python 3.11

python3.11 -m venv myenv

# Activate the virtual environment and check for errors

if source myenv/bin/activate; then

echo "Virtual environment activated successfully."

else

echo "Error: Failed to activate virtual environment."

exit 1

fi

# Ensure pip is up-to-date within the virtual environment

pip install --upgrade pip

# Install required packages

sudo apt install -y curl git gcc python3-dev python3-distutils python3-pip python-is-python3 libgl1 libglib2.0-0 libsm6 libxrender1 libxext6 python3-distutils clang

# Clone the stable-diffusion-webui repository

git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui || { echo "Error: Failed to clone repository." ; exit 1; }

# Change to the stable-diffusion-webui directory

cd stable-diffusion-webui || { echo "Error: Failed to change directory." ; exit 1; }

# 'Fix' the issue with Python running in PRoot (if applicable)

export ANDROID_DATA=anything

# Install required Python packages

pip install -r requirements.txt || { echo "Error: Failed to install requirements." ; exit 1; }

# Install xformers

pip install xformers || { echo "Error: Failed to install xformers." ; exit 1; }

# Install udocker

pip install udocker || { echo "Error: Failed to install udocker." ; exit 1; }

# Install open-webui

pip install open-webui || { echo "Error: Failed to install open-webui." ; exit 1; }

echo "Stable Diffusion installation complete!"

}

# Function to install Ollama

install_ollama() {

# Install Ollama using the official installation script

curl -fsSL https://ollama.com/install.sh | sh

echo "Ollama installation complete!"

}

# Main loop to display the menu and process user choices

while true; do

show_menu

case $choice in

1)

install_stable_diffusion

;;

2)

install_ollama

;;

3)

echo "Exiting..."

exit 0

;;

*)

echo "Invalid choice. Please try again."

;;

esac

done
