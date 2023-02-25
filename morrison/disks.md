## sgdisk
```
-o: erase/clear gpt data structure
-g: ensure gpt
-n: --new partnum:start:end
-t: --type partnum:hexcode (from sgdisk -L)
```
550mb is the max and is recommended. After that, check with `sudo cfdisk /dev/nvme0n1`

Update `bootpart` and `rootpart` in config from `lsblk`

## Disk inspection
```
# --fs flag retrieves UUID, which is also at `/dev/disk/by-uuid/UUID`
lsblk --fs
# alternatively, read symlink
ls -l /dev/disk/by-uuid
```

# Getting root disk's uuid

```bash
# for interactive usage, use `sudo blkid`

for uuid in /dev/disk/by-uuid/*
do
	if test $(readlink -f $uuid) = $rootpart
	then
		luksuuid=$uuid
		break
	fi
done

```
