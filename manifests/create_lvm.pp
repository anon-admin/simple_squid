class squid::create_lvm($vgname = "DATA") inherits storage {
  
  if $storage::squid {
    include squid

    $squid_lvname = $squid::squid_lvname
    $squid_lvsize = $squid::squid_lvsize
    $squid_lvfs = $squid::squid_lvfs
    $squid_mountpoint = $squid::squid_mountpoint

    if ($::blockdevice_sda_vendor == "QEMU") or ($::blockdevice_sdb_vendor == "QEMU") {
      $real_squid_lvsize = "1G"
    } else {
      $real_squid_lvsize = $acng_lvsize
    }

    storage::lvm::createlv { "${squid_lvname}":
      vgname     => $vgname,
      size       => "${real_squid_lvsize}",
      fstype     => "${squid_lvfs}",
      mountpoint => "${$squid_mountpoint}"
    }
    
    include squid::clean

  }

}
