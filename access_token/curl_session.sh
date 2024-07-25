#!/bin/bash

# Define the authentication endpoint and credentials
AUTH_URL="https://your-auth-server.com/oauth/token"
CLIENT_ID="your_client_id"
CLIENT_SECRET="your_client_secret"
USERNAME="your_username"
PASSWORD="your_password"

# Send a POST request to obtain the access token
RESPONSE=$(curl -s -X POST $AUTH_URL \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d "grant_type=password" \
    -d "client_id=$CLIENT_ID" \
    -d "client_secret=$CLIENT_SECRET" \
    -d "username=$USERNAME" \
    -d "password=$PASSWORD")

# Extract the access token from the response using jq
ACCESS_TOKEN=$(echo $RESPONSE | jq -r '.access_token')

# Extract the access token using grep and sed
access_token=$(echo $response | grep -oP '(?<="access_token": ")[^"]*')

# Check if the access token was obtained successfully
if [ "$ACCESS_TOKEN" != "null" ]; then
    echo "Access Token: $ACCESS_TOKEN"
else
    echo "Failed to obtain access token"
    exit 1
fi

# Use the access token in subsequent requests
# Example: Sending a GET request to a protected endpoint
PROTECTED_URL="https://your-api-server.com/protected/resource"
RESPONSE=$(curl -s -X GET $PROTECTED_URL \
    -H "Authorization: Bearer $ACCESS_TOKEN")

# Output the response
echo "Response from protected endpoint:"
echo $RESPONSE
