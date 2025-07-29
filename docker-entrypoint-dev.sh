#!/bin/bash

set -e

echo "=== Rails Development Setup ==="

# Remove a potentially pre-existing server.pid for Rails
echo "Removing server.pid..."
rm -f /rails/tmp/pids/server.pid

# Check if gems are installed, install if not
echo "Checking gems..."
if ! bundle check > /dev/null 2>&1; then
    echo "Installing missing gems..."
    bundle install
else
    echo "All gems are installed"
fi

# Database setup
echo "Setting up database..."
bin/rails db:prepare

echo "=== Setup complete ==="

# Execute main command
exec "$@"
