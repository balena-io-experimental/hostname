#!/bin/bash

echo "--- Hostname ---"

# Check we can hit the supervisor API
if [[ -z "$BALENA_SUPERVISOR_ADDRESS" || -z "$BALENA_SUPERVISOR_ADDRESS" ]]; then
  echo "Could not set hostname: BALENA_SUPERVISOR_ADDRESS and BALENA_SUPERVISOR_ADDRESS were not provided."
  echo "Add 'io.balena.features.supervisor-api' label to allow interacting with the supervisor."
  echo "See https://www.balena.io/docs/reference/supervisor/supervisor-api/#http-api-reference for details."
  exit 0
fi

# Get current hostname
CURRENT_HOSTNAME=$(curl -sL "$BALENA_SUPERVISOR_ADDRESS/v1/device/host-config?apikey=$BALENA_SUPERVISOR_API_KEY" | jq -r '.network.hostname')
echo "Current hostname: $CURRENT_HOSTNAME"

# Skip if no SET_HOSTNAME
# We can't use HOSTNAME as the user input because alpine already prepopulates it with the container's hostname which is different than the host
if [[ -z "$SET_HOSTNAME" ]]; then
  echo "Skipping hostname set: SET_HOSTNAME was not provided."
  exit 0
fi

echo "Target hostname: $SET_HOSTNAME"

# Skip if target hostname already applied
if [[ "$CURRENT_HOSTNAME" == "$SET_HOSTNAME" ]]; then
  echo "Skipping hostname set: target matches current hostname."
  exit 0
fi

# Set target hostname
echo "Setting target hostname..."
curl -sL -X PATCH --header "Content-Type:application/json" \
    --data '{"network": {"hostname": "'$SET_HOSTNAME'"}}' \
    "$BALENA_SUPERVISOR_ADDRESS/v1/device/host-config?apikey=$BALENA_SUPERVISOR_API_KEY"
echo -e "\nHostname updated!"

exit 0