#!/usr/bin/env bash

set -e

# Check if repository is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 owner/repo [-v]"
    echo "  -v    Enable verbose logging"
    exit 1
fi

REPO=$1
OUTPUT_FILE="issues.csv"
PER_PAGE=100
PAGE=1
VERBOSE=false

# Check for verbose flag
if [[ "$2" == "-v" ]]; then
    VERBOSE=true
fi

# Verbose logging function
log() {
    if [ "$VERBOSE" = true ]; then
        echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
    fi
}

# Function to calculate days between two dates
days_between() {
    local start_date=$(date -d "$1" +%s)
    local end_date=$(date -d "$2" +%s)
    echo $(((end_date - start_date) / 86400))
}

log "Starting GitHub Issues to CSV script for repository: $REPO"

# Create CSV header
echo "Issue Name,Date Opened,Date Last Updated,Days Open" >$OUTPUT_FILE
log "Created CSV file: $OUTPUT_FILE"

# Fetch open issues from GitHub API with pagination
while true; do
    log "Fetching page $PAGE of issues"

    # Fetch headers and issues in a single curl command
    response=$(curl -s -i "https://api.github.com/repos/$REPO/issues?state=open&per_page=$PER_PAGE&page=$PAGE")

    # Separate headers from body
    headers=$(echo "$response" | sed -n '1,/^\r?$/p')
    body=$(echo "$response" | sed '1,/^\r?$/d')

    # Parse rate limit information
    remaining=$(echo "$headers" | grep -i "^x-ratelimit-remaining" | cut -d: -f2 | tr -d ' \r')
    reset_time=$(echo "$headers" | grep -i "^x-ratelimit-reset" | cut -d: -f2 | tr -d ' \r')

    # Check if remaining is a number
    if ! [[ "$remaining" =~ ^[0-9]+$ ]]; then
        log "Error: Could not parse rate limit. Response headers:"
        log "$headers"
        exit 1
    fi

    log "Remaining API calls: $remaining"
    if [ "$remaining" -le 10 ]; then
        current_time=$(date +%s)
        sleep_time=$((reset_time - current_time + 10))
        log "Rate limit nearly exceeded. Sleeping for $sleep_time seconds."
        sleep $sleep_time
    fi

    echo "$body" >issues.json

    # Check if the body is valid JSON
    if ! echo "$body" | jq empty >/dev/null 2>&1; then
        log "Error: Invalid JSON response. Raw response body:"
        log "$body"
        exit 1
    fi

    issue_count=$(echo "$body" | jq '. | length')
    log "Fetched $issue_count issues"

    # Break the loop if no more issues
    if [[ "$issue_count" == 0 ]]; then
        log "No more issues to fetch. Exiting loop."
        break
    fi

    echo "$body" | jq -r '.[] | [
        .title,
        .created_at,
        .updated_at,
        (now | strftime("%Y-%m-%d"))
    ] | @csv' | while IFS=',' read -r title created_at updated_at current_date; do
        echo "issue"
        # Remove quotes from dates
        created_at=$(echo $created_at | tr -d '"')
        updated_at=$(echo $updated_at | tr -d '"')
        current_date=$(echo $current_date | tr -d '"')

        # Calculate days open
        days_open=$(days_between "$created_at" "$current_date")

        # Append to CSV file
        echo "\"$title\",$created_at,$updated_at,$days_open" >>$OUTPUT_FILE
        log "Added issue: $title"
    done

    PAGE=$((PAGE + 1))
    log "Moving to page $PAGE"
done

log "CSV file '$OUTPUT_FILE' has been generated."
echo "CSV file '$OUTPUT_FILE' has been generated."
