#!/bin/bash

# Function to start Gollum instance
start_gollum() {
    local repository_path="$1"
    local port="$2"
    local base_path="$3"
    local config_file="$4"

    gollum "$repository_path" --port "$port" --base_path "$base_path" --config "$config_file"
}

# Function to stop Gollum
stop_gollum() {
    pkill -f "gollum --port"
}


ensure_git() {
    local target_dir=$1
    local current_dir=$(pwd)  # Save current working directory



    # Check if .git directory exists inside the target directory
    if [ ! -d "$target_dir/.git" ]; then
        echo "Initializing Git repository in $target_dir"
        # Change into the target directory
        cd "$target_dir" || exit

        # Initialize Git repository
        git init

        # You can add initial commits or configuration if needed
        git add .
        git commit -m "Initial commit"

        echo "Git repository initialized successfully in $target_dir."
    else
        echo "Git repository already exists in $target_dir"
    fi
    
    cd "$current_dir" || exit
}

# Ensure git repos
ensure_git "loser/"
ensure_git "expoweb/"

# Start Gollum instances
start_gollum "loser/" "4560" "/" "gollum_config.rb" &
start_gollum "expoweb/" "4561" "/" "gollum_config.rb" &

mkdocs serve --config-file mkdocs_config.yaml &

# This is very hacky - we need to do better
trap 'stop_gollum; pkill -f "mkdocs serve"; exit' SIGINT SIGTERM

echo ""
echo "Daemons started"
echo ""
echo ""
echo ""
echo "Serving loser repository on http://localhost:4560/gollum/overview"
echo "Serving expoweb repository on http://localhost:4561/gollum/overview"
echo "Serving mkdocs on http://localhost:4562"
echo ""
echo ""
echo ""

wait

