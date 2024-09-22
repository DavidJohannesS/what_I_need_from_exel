#!/bin/bash

# Source the other scripts
source ./store_data.sh
source ./get_data.sh

# Declare arrays to hold expenses and savings
declare -A expenses
declare -A savings

# Prompt for the password once at launch
read -sp "Enter password: " password
echo

# Function to display the main menu
main_menu() {
    load_data
    local options=("Add Expense" "Add Savings" "View Data" "Exit")
    local choice
    local index=0

    while true; do
        clear
        echo "Expense Manager"
        echo "---------------"
        for i in "${!options[@]}"; do
            if [ $i -eq $index ]; then
                echo "> ${options[$i]}"
            else
                echo "  ${options[$i]}"
            fi
        done

        read -rsn1 input
        case $input in
            j) ((index = (index + 1) % ${#options[@]})) ;;
            k) ((index = (index - 1 + ${#options[@]}) % ${#options[@]})) ;;
            "") choice=${options[$index]}
                case $choice in
                    "Add Expense")
                        add_expense
                        save_data
                        encrypt_data
                        ;;
                    "Add Savings")
                        add_savings
                        save_data
                        encrypt_data
                        ;;
                    "View Data")
                        decrypt_data
                        display_data
                        ;;
                    "Exit")
                        break
                        ;;
                esac
                ;;
        esac
    done
}

# Run the main menu
main_menu

