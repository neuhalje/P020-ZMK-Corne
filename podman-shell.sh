#!/bin/bash

podman run --rm \
	   -ti \
  	   --security-opt label=disable \
	   --workdir /workspaces/zmk \
 	   -v zmk:/workspaces/zmk \
  	   -v zmk-config:/workspaces/zmk-config \
       -v zmk-modules:/workspaces/zmk-modules \
       localhost/p020-zmk-builder \
	   /bin/bash

