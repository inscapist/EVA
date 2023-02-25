# LUKS

```
  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/FIND_UUID_WITH_LS_L";
      name = "root";
      preLVM = true;
      allowDiscards = true;
    };
  };
```
or

```
# Configuration options for LUKS Device
boot.initrd.luks.devices = {
  crypted = {
    device = "/dev/disk/by-partuuid/<PARTUUID of /dev/sda1>";
    header = "/dev/disk/by-partuuid/<PARTUUID of /dev/sdb2>";
    allowDiscards = true; # Used if primary device is a SSD
    preLVM = true;
  };
};
```

We must specify the device directive which is a path that points to the encrypted primary partition /dev/sda1, as well as header which is a path that points to the LUKS2 Header located on /dev/sdb2.

These paths can be specified in more than one way. You can see the various ways that this path is specified by listing the subdirectories in /dev/disk.

I recommend specifying the paths using /dev/disk/by-partuuid instead of /dev/disk/by-uuid, because /dev/sda1 does not have a uuid assigned to it, since it doesn't have a filesystem.

Hence in order to find the UUIDs of /dev/sda1 and /deb/sdb2, run:

blkid /dev/sda1 -s PARTUUID

Or you may simply run ls -l /dev/disk/by-partuuid
