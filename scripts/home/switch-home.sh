#!/bin/sh
pushd $(dirname $0)/../../users/$USER/
	if [[ $CONF_HEADLESS != 0 ]] 
	then
		ln -sf headless.nix home.nix
	else
		ln -sf gui.nix home.nix
	fi
popd