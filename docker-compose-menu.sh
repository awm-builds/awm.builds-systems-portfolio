#!/bin/bash

menu() {
    clear
    echo ""
    echo "========================================"
    echo "     Docker Compose Management"
    echo "========================================"
    echo ""
    echo "1) Run containers (START)"
    echo "   Command: docker compose up --build"
    echo ""
    echo "2) Stop containers (SAFE - keeps data)"
    echo "   Command: docker compose down"
    echo ""
    echo "3) Reset database (DANGEROUS - deletes data)"
    echo "   Command: docker compose down -v"
    echo ""
    echo "4) Exit"
    echo ""
    echo "========================================"
    read -p "Select option (1, 2, 3, or 4): " choice
    
    case $choice in
        1) run_start ;;
        2) stop_safe ;;
        3) reset_dangerous ;;
        4) exit 0 ;;
        *) invalid_choice ;;
    esac
}

run_start() {
    echo ""
    echo "Starting containers..."
    docker compose up --build
    echo ""
    echo "SUCCESS: Containers started."
    read -p "Press Enter to continue..."
    menu
}

stop_safe() {
    echo ""
    echo "Stopping containers (keeping data)..."
    docker compose down
    echo ""
    echo "SUCCESS: Containers stopped. Data preserved."
    read -p "Press Enter to continue..."
    menu
}

reset_dangerous() {
    echo ""
    echo "========================================"
    echo "            !! WARNING !!"
    echo "========================================"
    echo "This will PERMANENTLY DELETE your database!"
    echo "All data in the pgdata volume will be lost."
    echo "========================================"
    echo ""
    read -p "Type 'DELETE' to confirm (all caps): " confirm
    
    if [ "$confirm" != "DELETE" ]; then
        echo "Cancelled. Database preserved."
        read -p "Press Enter to continue..."
        menu
        return
    fi
    
    echo ""
    echo "Deleting database volume..."
    docker compose down -v
    
    if [ $? -ne 0 ]; then
        echo ""
        echo "ERROR: Database reset FAILED"
        read -p "Press Enter to continue..."
        menu
        return
    fi
    
    echo ""
    echo "SUCCESS: Database reset complete."
    read -p "Press Enter to continue..."
    menu
}

invalid_choice() {
    echo ""
    echo "Invalid selection. Please enter 1, 2, 3, or 4."
    read -p "Press Enter to continue..."
    menu
}

# Start menu
menu