#!/bin/sh
pushd $(dirname $0)/../../users/$USER/
	if [[ $CONF_GUI == 1 ]] 
	then
		ln -sf gui.nix home.nix
	else
		ln -sf headless.nix home.nix
	fi
popd
