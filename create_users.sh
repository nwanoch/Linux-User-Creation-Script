#!/bin/bash

# Check if the script is executed with a file argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

input_file=$1
log_file="/var/log/user_management.log"
password_file="/var/secure/user_passwords.txt"

# Function to generate a random password
generate_password() {
    openssl rand -base64 12 | tr -d '/+=' | cut -c1-12
}

# Loop through each line in the input file
while IFS=';' read -r username groups; do
    # Remove leading/trailing whitespace
    username=$(echo "$username" | tr -d '[:space:]')
    groups=$(echo "$groups" | tr -d '[:space:]')

    # Check if the user already exists
    if id "$username" &>/dev/null; then
        echo "User $username already exists. Skipping."
        echo "$(date) - User $username already exists. Skipping." >> "$log_file"
        continue
    fi

    # Create the user
    useradd -m -s /bin/bash "$username"

    # Create groups if they don't exist and add the user to groups
    IFS=',' read -ra user_groups <<< "$groups"
    for group in "${user_groups[@]}"; do
        if ! grep -q "^$group:" /etc/group; then
            groupadd "$group"
        fi
        usermod -aG "$group" "$username"
    done

    # Generate a password
    password=$(generate_password)

    # Set the password for the user
    echo "$username:$password" | chpasswd

    # Log actions
    echo "$(date) - Created user $username with groups $groups." >> "$log_file"

    # Store passwords securely
    echo "$username,$password" >> "$password_file"

    # Ensure home directory permissions
    chown -R "$username:$username" "/home/$username"
    chmod 700 "/home/$username"
done < "$input_file"

echo "User creation process complete."
