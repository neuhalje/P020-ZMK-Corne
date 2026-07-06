#!/bin/bash

# https://zmk.dev/docs/troubleshooting/connection-issues
podman run --rm \
	   -ti \
  	   --security-opt label=disable \
	   --workdir /workspaces/zmk \
 	   -v zmk:/workspaces/zmk \
  	   -v zmk-config:/workspaces/zmk-config \
       -v zmk-modules:/workspaces/zmk-modules \
           localhost/p020-zmk-builder \
	   west build  \
	   --pristine=always \
	   -s /workspaces/zmk/app \
	   -d build/reset \
	   -b nice_nano@2.0.0//zmk  \
	   -- \
	   -DSHIELD="settings_reset" \
	   -DZMK_CONFIG=/workspaces/zmk-config/config/ \
       -DZMK_EXTRA_MODULES="/workspaces/zmk-modules/oskey"


cfg="../P020-zmk/build/left/zephyr/.config"
if [ -f "${cfg}" ]; then
   grep -v -e "^#" -e "^$" "${cfg}" | sort
else
    echo "No Kconfig output in ${cfg}"
    stat "${cfg}"
fi


echo see  ../P020-zmk/build/reset/zephyr/


