# User Management Bash Script

## Task Description

The task as a SysOps engineer is to create a bash script called create_users.sh that automates the process of creating user accounts on a Linux system based on input provided in a text file. Each line in the input file should specify a username and associated groups delimited by semicolons (user;group1,group2,...). The script should handle user and group creation, set up home directories with appropriate permissions, generate random passwords, and log all actions.

## Solution Overview

The create_users.sh script accomplishes the following tasks:

- Read Input: Reads usernames and associated groups from a specified input file.
- Create Users and Groups: Creates new users if they do not exist, along with any specified groups.
- Set Permissions: Sets up home directories for each user with secure permissions.
- Generate Passwords: Generates random passwords for each user and securely stores them.
- Logging: Logs all actions performed by the script to /var/log/user_management.log.
- Error Handling: Handles scenarios like existing users gracefully, skipping duplicates.
- Documentation: Includes a README.md file to explain the task, solution, and how to run the script.

## How to Run

### Example input file users.txt:

light;sudo,dev,www-data
idimma;sudo
mayowa;dev,www-data

### Execute the Script:

Run the script with the input file as an argument:

```bash
bash create_users.sh users.txt
```

Verify Output:
Check /var/log/user_management.log for detailed logs of all actions.
Verify /var/secure/user_passwords.txt for securely stored user passwords.

Technical Article
For a detailed explanation of the script implementation and rationale behind each step, please refer to the technical [article](URL)
associated with this repository.
