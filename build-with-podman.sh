#!/bin/bash

podman run --rm \
	   -ti \
  	   --security-opt label=disable \
	   --workdir /workspaces/zmk \
 	   -v zmk:/workspaces/zmk \
  	   -v zmk-config:/workspaces/zmk-config \
           localhost/p020-zmk-builder \
	   west build  \
	   --pristine=always \
	   -s /workspaces/zmk/app \
	   -d build/left \
	   -b nice_nano@2.0.0//zmk  \
	   -S studio-rpc-usb-uart \
	   -- \
	   -DSHIELD="corne_left nice_view_adapter nice_view" \
	   -DZMK_CONFIG=/workspaces/zmk-config/config/

podman run --rm \
	   -ti \
  	   --security-opt label=disable \
	   --workdir /workspaces/zmk \
 	   -v zmk:/workspaces/zmk \
  	   -v zmk-config:/workspaces/zmk-config \
           localhost/p020-zmk-builder \
	   west build  \
	   --pristine=always \
	   -s /workspaces/zmk/app \
	   -d build/right \
	   -b nice_nano@2.0.0//zmk  \
	   -- \
	   -DSHIELD="corne_right nice_view_adapter nice_view" \
	   -DZMK_CONFIG=/workspaces/zmk-config/config/

echo see  ../P020-zmk/build/left/zephyr/
echo see  ../P020-zmk/build/right/zephyr/
