#!/bin/bash
# Script to invoke a Lambda function locally

# Check if function name is provided
if [ -z "$1" ]; then
    echo "Error: Function name is required"
    echo "Usage: ./local-invoke.sh <function-name> [event-file]"
    exit 1
fi

FUNCTION_NAME=$1
EVENT_FILE=$2

# Convert function name to resource name (remove hyphens)
RESOURCE_NAME="${FUNCTION_NAME//-/}Function"

# Check if event file is provided
if [ -z "$EVENT_FILE" ]; then
    # Use default event
    EVENT_DATA='{
        "queryStringParameters": {
            "name": "Local Test"
        },
        "pathParameters": {}
    }'
    
    # Create temporary event file
    TMP_EVENT_FILE=$(mktemp)
    echo "$EVENT_DATA" > "$TMP_EVENT_FILE"
    
    # Invoke function
    echo "Invoking $FUNCTION_NAME with default event..."
    sam local invoke "$RESOURCE_NAME" -e "$TMP_EVENT_FILE"
    
    # Clean up
    rm "$TMP_EVENT_FILE"
else
    # Check if event file exists
    if [ ! -f "$EVENT_FILE" ]; then
        echo "Error: Event file '$EVENT_FILE' not found"
        exit 1
    fi
    
    # Invoke function with provided event file
    echo "Invoking $FUNCTION_NAME with event from $EVENT_FILE..."
    sam local invoke "$RESOURCE_NAME" -e "$EVENT_FILE"
fi
