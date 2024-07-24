#!/bin/bash

# Check Repositories Size
repo_size=$(sudo du -sh /var/opt/gitlab/git-data/repositories | awk '{print $1}')
echo "Repositories Size: $repo_size"

# Check Database Size
db_size=$(sudo gitlab-psql -d gitlabhq_production -c "SELECT pg_size_pretty(pg_database_size('gitlabhq_production'));" | awk 'NR==3 {print $1, $2}')
echo "Database Size: $db_size"

# Check Logs Size
logs_size=$(sudo du -sh /var/log/gitlab | awk '{print $1}')
echo "Logs Size: $logs_size"

# Check Backups Size
backup_size=$(sudo du -sh /var/opt/gitlab/backups | awk '{print $1}')
echo "Backups Size: $backup_size"

# Calculate Total Size (excluding unit conversion)
echo "Note: Sizes are in different units. Convert them to the same unit for total size calculation."
