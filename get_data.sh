#!/bin/bash

# Function to decrypt the YAML file
decrypt_data() {
    openssl enc -d -aes-256-cbc -in data.yaml.enc -out data.yaml -pass pass:$password
}

# Function to display the data
display_data() {
    clear
    cat data.yaml
    read -p "Press any key to return to the menu..."
}

# Function to load data into arrays
load_data() {
    decrypt_data
    while IFS=": " read -r key value; do
        if [[ $key == "expenses" ]]; then
            section="expenses"
        elif [[ $key == "savings" ]]; then
            section="savings"
        elif [[ $section == "expenses" ]]; then
            expenses[$key]=$value
        elif [[ $section == "savings" ]]; then
            savings[$key]=$value
        fi
    done < data.yaml
    rm data.yaml
}

