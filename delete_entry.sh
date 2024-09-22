#!/bin/bash

# Function to delete an expense
delete_expense() {
    local expense_list=()
    for name in "${!expenses[@]}"; do
        expense_list+=("$name: ${expenses[$name]}")
    done

    if [ ${#expense_list[@]} -eq 0 ]; then
        echo "No expenses to delete."
        read -p "Press any key to return to the menu..."
        return
    fi

    local index=0
    while true; do
        clear
        echo "Delete Expense"
        echo "--------------"
        for i in "${!expense_list[@]}"; do
            if [ $i -eq $index ]; then
                echo "> ${expense_list[$i]}"
            else
                echo "  ${expense_list[$i]}"
            fi
        done

        read -rsn1 input
        case $input in
            j) ((index = (index + 1) % ${#expense_list[@]})) ;;
            k) ((index = (index - 1 + ${#expense_list[@]}) % ${#expense_list[@]})) ;;
            "") local selected_expense=${expense_list[$index]}
                local expense_name=$(echo "$selected_expense" | cut -d':' -f1)
                unset expenses[$expense_name]
                break
                ;;
        esac
    done
}

# Function to delete a savings item
delete_savings() {
    local savings_list=()
    for name in "${!savings[@]}"; do
        savings_list+=("$name: ${savings[$name]}")
    done

    if [ ${#savings_list[@]} -eq 0 ]; then
        echo "No savings items to delete."
        read -p "Press any key to return to the menu..."
        return
    fi

    local index=0
    while true; do
        clear
        echo "Delete Savings"
        echo "--------------"
        for i in "${!savings_list[@]}"; do
            if [ $i -eq $index ]; then
                echo "> ${savings_list[$i]}"
            else
                echo "  ${savings_list[$i]}"
            fi
        done

        read -rsn1 input
        case $input in
            j) ((index = (index + 1) % ${#savings_list[@]})) ;;
            k) ((index = (index - 1 + ${#savings_list[@]}) % ${#savings_list[@]})) ;;
            "") local selected_savings=${savings_list[$index]}
                local savings_name=$(echo "$selected_savings" | cut -d':' -f1)
                unset savings[$savings_name]
                break
                ;;
        esac
    done
}

# Function to save data to a YAML file
save_data() {
    echo "expenses:" > data.yaml
    for name in "${!expenses[@]}"; do
        echo "  $name: ${expenses[$name]}" >> data.yaml
    done

    echo "savings:" >> data.yaml
    for name in "${!savings[@]}"; do
        echo "  $name: ${savings[$name]}" >> data.yaml
    done
}

# Function to encrypt the YAML file
encrypt_data() {
    openssl enc -aes-256-cbc -salt -in data.yaml -out data.yaml.enc -pass pass:$password
    rm data.yaml
}

# Function to delete an entry
delete_entry() {
    local options=("Delete Expense" "Delete Savings" "Cancel")
    local choice
    local index=0

    while true; do
        clear
        echo "Delete Entry"
        echo "------------"
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
                    "Delete Expense")
                        delete_expense
                        save_data
                        encrypt_data
                        ;;
                    "Delete Savings")
                        delete_savings
                        save_data
                        encrypt_data
                        ;;
                    "Cancel")
                        break
                        ;;
                esac
                ;;
        esac
    done
}

