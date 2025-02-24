#!/bin/bash
check_root(){
if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root!" 1>&2
        exit 1
fi
}

add_user(){
# Get the username and group from input
read -r -p "Enter username to add: " username
read -r -p "Enter group to assign: " group

# Add group if it dosen't exist
if ! grep -q "^$group:" /etc/group; then
        echo "Creating group $group..."
        groupadd "$group"
fi

# Create user and assign to group
echo "Creating user $username..."
useradd -m -G "$group" "$username"

# Set a password for the user
echo "Setting password for $username..."
passwd "$username"
echo "User $username added sucessfully!"
}

remove_user(){
        read -r -p "Enter username to remove: " username
        if ! id "$username" &>/dev/null; then
                echo "User $username does not exist!"
        fi
        #Ask for confirmation before removing
        read -r -p "Are you sure you want to delete user $username and their home dir? [y/N]: " confirm
        if [[ $confirm =~ ^[Yy]$ ]]; then
                echo "Removing user $username..."
                userdel -r "$username"
                echo "User $username removed successfully"
        else 
                echo "User removal cancelled."
        fi
}

main_menu(){
        echo "User and Group Management Script"
        echo "--------------------------------"
        echo "1. Add a user"
        echo "2. Remove a user"
        echo "3. Exit"
        echo "--------------------------------"
        read -r -p "Select an option: " choice

        case $choice in
                1) add_user ;;
                2) remove_user ;;
                3) exit 0 ;;
                *) echo "Invalid choice. Please try again." ;;
        esac

}

# Run the script
check_root
main_menu
