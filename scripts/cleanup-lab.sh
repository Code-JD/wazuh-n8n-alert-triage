#!/bin/bash

echo "=================================="
echo "Wazuh n8n Lab - Laptop Cleanup Script"
echo "=================================="
echo ""

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored status
print_status() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

echo "This script will clean up:"
echo "  - n8n Docker containers and volumes"
echo "  - n8n project directories"
echo "  - Wazuh agent (if installed)"
echo "  - Unused Docker resources"
echo ""
read -p "Continue? (y/n): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Cleanup cancelled."
    exit 0
fi

echo ""
echo "Starting cleanup..."
echo ""

# Step 1: Stop and remove n8n containers
echo "Step 1: Removing n8n Docker stack..."
if [ -d ~/n8n-lab ]; then
    cd ~/n8n-lab
    if [ -f docker-compose.yml ]; then
        print_status "Found docker-compose.yml, stopping containers..."
        docker-compose down -v 2>/dev/null
        print_status "n8n containers and volumes removed"
    else
        print_warning "No docker-compose.yml found in ~/n8n-lab"
    fi
    cd ~
else
    print_warning "~/n8n-lab directory not found"
fi

# Step 2: Remove any lingering n8n containers
echo ""
echo "Step 2: Checking for lingering n8n containers..."
N8N_CONTAINERS=$(docker ps -a | grep n8n | awk '{print $1}')
if [ ! -z "$N8N_CONTAINERS" ]; then
    echo "$N8N_CONTAINERS" | xargs docker rm -f 2>/dev/null
    print_status "Removed lingering n8n containers"
else
    print_status "No lingering n8n containers found"
fi

# Step 3: Remove n8n volumes
echo ""
echo "Step 3: Removing n8n volumes..."
N8N_VOLUMES=$(docker volume ls | grep n8n | awk '{print $2}')
if [ ! -z "$N8N_VOLUMES" ]; then
    echo "$N8N_VOLUMES" | xargs docker volume rm 2>/dev/null
    print_status "Removed n8n volumes"
else
    print_status "No n8n volumes found"
fi

# Step 4: Remove project directories
echo ""
echo "Step 4: Removing project directories..."
if [ -d ~/n8n-lab ]; then
    rm -rf ~/n8n-lab
    print_status "Removed ~/n8n-lab directory"
else
    print_status "~/n8n-lab already removed"
fi

# Check for any other n8n or wazuh directories
OTHER_DIRS=$(ls ~/ 2>/dev/null | grep -iE 'n8n|wazuh')
if [ ! -z "$OTHER_DIRS" ]; then
    print_warning "Found other potential project directories:"
    echo "$OTHER_DIRS"
    read -p "Remove these as well? (y/n): " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "$OTHER_DIRS" | while read dir; do
            rm -rf ~/"$dir"
            print_status "Removed ~/$dir"
        done
    fi
fi

# Step 5: Check and remove Wazuh agent
echo ""
echo "Step 5: Checking for Wazuh agent..."
if sudo systemctl status wazuh-agent &>/dev/null; then
    print_status "Wazuh agent found, removing..."
    sudo systemctl stop wazuh-agent 2>/dev/null
    sudo apt remove wazuh-agent -y 2>/dev/null
    sudo rm -rf /var/ossec 2>/dev/null
    print_status "Wazuh agent removed"
else
    print_status "No Wazuh agent installed"
fi

# Step 6: Docker system cleanup
echo ""
echo "Step 6: Cleaning up Docker system..."
print_warning "This will remove ALL unused Docker resources (images, containers, networks)"
read -p "Proceed with Docker system prune? (y/n): " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    docker system prune -a -f --volumes
    print_status "Docker system cleaned"
else
    print_warning "Skipped Docker system prune"
fi

# Step 7: Verification
echo ""
echo "=================================="
echo "Cleanup Verification"
echo "=================================="
echo ""

echo "Docker Containers:"
CONTAINERS=$(docker ps -a)
if [ -z "$CONTAINERS" ] || [ "$(echo "$CONTAINERS" | wc -l)" -eq 1 ]; then
    print_status "No containers running"
else
    print_warning "Some containers still exist:"
    docker ps -a
fi

echo ""
echo "Docker Volumes:"
VOLUMES=$(docker volume ls)
if [ -z "$VOLUMES" ] || [ "$(echo "$VOLUMES" | wc -l)" -eq 1 ]; then
    print_status "No volumes remaining"
else
    print_warning "Some volumes still exist:"
    docker volume ls
fi

echo ""
echo "Project Directories:"
PROJECT_DIRS=$(ls ~/ 2>/dev/null | grep -iE 'n8n|wazuh')
if [ -z "$PROJECT_DIRS" ]; then
    print_status "No project directories found"
else
    print_warning "Found directories:"
    echo "$PROJECT_DIRS"
fi

echo ""
echo "Wazuh Agent:"
if sudo systemctl status wazuh-agent &>/dev/null; then
    print_error "Wazuh agent still installed"
else
    print_status "Wazuh agent not installed"
fi

echo ""
echo "=================================="
echo "Cleanup Complete!"
echo "=================================="
echo ""
echo "Your laptop is ready for fresh deployment."
echo "Docker and Docker Compose are still installed and ready to use."
echo ""
