zpool create -f \
	-O compression=lz4 \
	-o ashift=12 \
	-O relatime=on \
	-O atime=off
	-O canmount=off \
	-O mountpoint=none \
	-O dnodesize=auto \
	-O normalization=formD \
	-o autotrim=on \
	$SYS_POOL $SYS_DISK

# NOTE: needed 'cos COW
zfs create -o refreservation=$RESERVED_SIZE -o mountpoint=none $SYS_POOL/reserved

zfs create $SYS_LOCAL_POOL
zfs create \
	-o xattr=sa \
	-o acltype=posixacl \
	-o canmount=on \
	-o mountpoint=/var \
	-o dedup=on \
	${SYS_LOCAL_POOL}/var
zfs create \
	-o compression=no \
	-V $SWAP_SIZE \
	${SYS_LOCAL_POOL}/swap

zfs create $SYS_SAFE_POOL
zfs set com.sun:auto-snapshot=true $SYS_SAFE_POOL
zfs create \
	-o canmount=on \
	-o mountpoint=/nix \
	-o dedup=on \
	${SYS_SAFE_POOL}/nix
zfs create \
	-o canmount=on \
	-o mountpoint=/home \
	-o dedup=on \
	${SYS_SAFE_POOL}/home
zfs create \
	-o canmount=on \
	-o mountpoint=/persist \
	-o dedup=on \
	${SYS_SAFE_POOL}/persist