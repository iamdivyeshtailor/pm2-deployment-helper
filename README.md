# PM2 Process Manager Script

This repository contains a Bash script to automate the setup and management of Node.js applications using [PM2](https://pm2.keymetrics.io/), a production process manager.

## Features

- **Interactive Setup**: Guides you through providing:
  - Project directory
  - Command to run (e.g., `yarn develop` or `npm run dev`)
  - Project name (for PM2 identification)
  - Optional port number
- **PM2 Installation**: Detects if PM2 is installed and offers to install it if not.
- **Process Persistence**: Saves the PM2 process, ensuring it persists after server reboots.

## Requirements

- Node.js and npm must be installed on your system.

## Usage

1. Clone this repository:
    ```bash
    git clone https://github.com/<your-username>/<repo-name>.git
    ```

2. Navigate to the cloned directory:
    ```bash
    cd <repo-name>
    ```

3. Make the script executable:
    ```bash
    chmod +x start_pm2_process.sh
    ```

4. Run the script:
    ```bash
    ./start_pm2_process.sh
    ```

5. Follow the on-screen prompts to configure and start your Node.js project with PM2.

## Example

```bash
Enter the path of the project directory: ./
Enter the command to run (e.g., 'yarn develop' or 'npm run dev'): yarn develop
Enter the project name (for PM2 identification): my-app
Do you want to define a specific port? (y/n): y
Enter the port number: 3000
Executing: pm2 start --name my-app -- PORT=3000 yarn develop
PM2 process saved successfully for project 'my-app'.
