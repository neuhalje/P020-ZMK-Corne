#!/bin/bash

podman run --rm \
	   -ti \
  	   --security-opt label=disable \
	   --workdir /workspaces/zmk \
 	   -v zmk:/workspaces/zmk \
  	   -v zmk-config:/workspaces/zmk-config \
           localhost/p020-zmk-builder \
	   /bin/bash

