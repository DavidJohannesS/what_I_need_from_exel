#!/bin/bash

# Function to add an expense
add_expense() {
    read -p "Enter expense name: " name
    read -p "Enter expense amount: " amount
    expenses[$name]=$amount
}

# Function to add a savings item
add_savings() {
    read -p "Enter savings name: " name
    read -p "Enter savings amount: " amount
    savings[$name]=$amount
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

