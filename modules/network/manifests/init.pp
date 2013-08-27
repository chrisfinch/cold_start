class network {
  package {'avahi-daemon': }

  file { "/etc/network/interfaces":
    content => template("network/interfaces"),
  }
  file { "/etc/rc.local":
    content => template("network/rc_local"),
    mode => '755',
  }
  file { "/usr/local/bin/try_adhoc_network":
    content => template("network/try_adhoc_network"),
    mode => '700',
  }
  file { "/etc/wpa_supplicant/wpa_supplicant.conf":
    content => template("network/wpa_supplicant_conf"),
  }
  file { "/boot/wpa_supplicant.txt":
    content => template("network/wpa_supplicant_conf"),
  }
  file { "/boot/hostname.txt":
    content => "radiodan",
  }
}
