#!/bin/bash

# Function to install PM2
install_pm2() {
    echo "Detecting system type..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux (Ubuntu/Debian-based)
        if [[ -x "$(command -v apt)" ]]; then
            echo "Installing PM2 on Ubuntu/Debian..."
            sudo apt update
            sudo apt install -y nodejs npm
            sudo npm install pm2 -g
        elif [[ -x "$(command -v yum)" ]]; then
            # Linux (CentOS/RHEL-based)
            echo "Installing PM2 on CentOS/RHEL..."
            sudo yum install -y nodejs npm
            sudo npm install pm2 -g
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # MacOS
        echo "Installing PM2 on macOS..."
        brew install node
        npm install pm2 -g
    elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
        # Windows using Git Bash or Cygwin
        echo "Please install PM2 manually on Windows (Node.js and npm required)."
        exit 1
    else
        echo "Unsupported OS. Please install PM2 manually."
        exit 1
    fi
    echo "PM2 installed successfully!"
}

# Check if PM2 is installed
if ! [ -x "$(command -v pm2)" ]; then
    echo "PM2 is not installed."
    read -p "Do you want to install PM2? (y/n): " install_pm2_choice
    if [ "$install_pm2_choice" == "y" ] || [ "$install_pm2_choice" == "Y" ]; then
        install_pm2
    else
        echo "PM2 is required to run this script. Exiting."
        exit 1
    fi
fi

# Step 1: Ask for the directory path
read -p "Enter the path of the project directory: " project_dir

# Step 2: Ask for the command to run using PM2
read -p "Enter the command to run (e.g., 'yarn develop' or 'npm run dev'): " run_command

# Step 3: Ask for the project name
read -p "Enter the project name (for PM2 identification): " project_name

# Step 4: Ask if a specific port is required (optional)
read -p "Do you want to define a specific port? (y/n): " define_port
if [ "$define_port" == "y" ] || [ "$define_port" == "Y" ]; then
    read -p "Enter the port number: " port_number
    env_variable="PORT=$port_number"
else
    env_variable=""
fi

# Step 5: Navigate to the project directory and start the process using PM2
cd "$project_dir" || { echo "Directory not found! Exiting."; exit 1; }

# Check if the user defined a port number
if [ -n "$env_variable" ]; then
    pm2_command="pm2 start --name $project_name -- $env_variable $run_command"
else
    pm2_command="pm2 start --name $project_name -- $run_command"
fi

# Execute the PM2 command
echo "Executing: $pm2_command"
eval $pm2_command

# Save the PM2 process list
echo "Saving the PM2 process list..."
pm2 save

# Inform the user that the process has been saved and will persist after a restart
echo "PM2 process saved successfully for project '$project_name'. The process will automatically restart on server reboot."
