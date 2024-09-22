#!/bin/bash

# Declare arrays to hold expenses and savings
declare -A expenses
declare -A savings

# Function to add an expense
add_expense() {
    local name=$1
    local amount=$2
    expenses[$name]=$amount
}

# Function to add a savings item
add_savings() {
    local name=$1
    local amount=$2
    savings[$name]=$amount
}

# Function to calculate total expenses
calculate_total_expenses() {
    local total=0
    for amount in "${expenses[@]}"; do
        total=$((total + amount))
    done
    echo $total
}

# Function to calculate total savings
calculate_total_savings() {
    local total=0
    for amount in "${savings[@]}"; do
        total=$((total + amount))
    done
    echo $total
}

# Function to display the main menu
main_menu() {
    local options=("Add Expense" "Add Savings" "View Expenses" "View Savings" "Calculate Total Expenses" "Calculate Total Savings" "Exit")
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
                        read -p "Enter expense name: " name
                        read -p "Enter expense amount: " amount
                        add_expense "$name" "$amount"
                        ;;
                    "Add Savings")
                        read -p "Enter savings name: " name
                        read -p "Enter savings amount: " amount
                        add_savings "$name" "$amount"
                        ;;
                    "View Expenses")
                        clear
                        echo "Expenses:"
                        for name in "${!expenses[@]}"; do
                            echo "$name: ${expenses[$name]}"
                        done
                        read -p "Press any key to return to the menu..."
                        ;;
                    "View Savings")
                        clear
                        echo "Savings:"
                        for name in "${!savings[@]}"; do
                            echo "$name: ${savings[$name]}"
                        done
                        read -p "Press any key to return to the menu..."
                        ;;
                    "Calculate Total Expenses")
                        total_expenses=$(calculate_total_expenses)
                        clear
                        echo "Total Expenses: $total_expenses"
                        read -p "Press any key to return to the menu..."
                        ;;
                    "Calculate Total Savings")
                        total_savings=$(calculate_total_savings)
                        clear
                        echo "Total Savings: $total_savings"
                        read -p "Press any key to return to the menu..."
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

