#!/bin/bash
# Setup for podman-machine
# follows https://zmk.dev/docs/development/local-toolchain/setup/container
#

ZMK_CONFIG=$(dirname $(readlink -f "$0"))
# No modules yet
ZMK_MODULES="${ZMK_CONFIG}/../P020-zmk-modules"


#
# zmk-config
#
if ! $(podman volume exists zmk-config); then
  echo "Createing zmk-config volume as ${ZMK_CONFIG}"
  podman volume create --driver local -o o=bind -o type=none \
   -o device="${ZMK_CONFIG}" zmk-config
fi

# 
# zmk
#
if ! $(podman volume exists zmk); then
  podman volume create --driver local -o o=bind -o type=none \
         -o device="$(pwd)/../P020-zmk" zmk
fi

#
# zmk modules
#
[ ! -d ${ZMK_MODULES} ] && mkdir "${ZMK_MODULES}"

if [ ! -d ${ZMK_MODULES}/oskey ]; then
	cd "${ZMK_MODULES}"
	git clone -b main https://github.com/mentaldesk/oskey.git oskey
	cd -
fi
	
# see https://zmk.dev/docs/features/modules
# 

if ! $(podman volume exists zmk-modules) ; then
   echo "Creating zmk-modules volume as ${ZMK_MODULES}"
   podman volume create --driver local -o o=bind -o type=none \
          -o device="${ZMK_MODULES}" zmk-modules
fi

#
# Build the ZMK container
if [ ! -d ../P020-zmk ]; then
	cd ..
	git clone git clone https://github.com/zmkfirmware/zmk.git P020-zmk
	cd -
fi

if [ ! $(podman image exists zmk-builder) ]; then
  cd ../P020-zmk
  podman build -t localhost/p020-zmk-builder -f Dockerfile .devcontainer
  cd -
fi


echo You now can build the firmware by running
echo ""
#  -v zmk-modules:/workspaces/zmk-modules \
echo podman run -it --rm \
  --security-opt label=disable \
  --workdir /workspaces/zmk \
  -v zmk:/workspaces/zmk \
  -v zmk-config:/workspaces/zmk-config \
  -v zmk-modules:/workspaces/zmk-modules \  
  -p 3000:3000 \
  localhost/p020-zmk-builder /bin/bash

echo
echo 'On the very first run call *inside the container*:'
echo
echo 'west init -l app/'
echo 'west update'

