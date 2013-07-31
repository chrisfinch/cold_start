class audio {
  package { "mpd": }
  package { "mpc": }
  package { "ncmpcpp": }
  package { "alsa-utils": }

  service { "mpd":
    ensure => "running",
    require => Package['mpd'],
  }

  exec { "umute":
    command => "amixer set -c 0 Master 70 unmute && amixer set -c 0 PCM 70 unmute",
    path    => "/usr/bin/",
    require => Package['alsa-utils'],
  }

  file { "/music":
    ensure => "directory",
    owner  => "mpd",
    group  => "radiodan",
    mode   => 750,
    require => Group['radiodan']
  }

  file { "/playlists":
    ensure => "directory",
    owner  => "mpd",
    group  => "radiodan",
    mode   => 750,
    require => Group['radiodan']
  }

  file { '/etc/mpd.conf':
    ensure  => present,
    require => Package['mpd'],
    notify => Service['mpd'],
    content => '
music_directory    "/music"
playlist_directory "/playlists"
db_file            "/var/lib/mpd/tag_cache"
log_file           "/var/log/mpd/mpd.log"
pid_file           "/var/run/mpd/pid"
user               "mpd"
bind_to_address    "localhost"
port               "6600"
auto_update        "yes"

audio_output {
  type            "alsa"
  name            "My ALSA Device"
  device          "hw:0,0"
  format          "44100:16:2"
  mixer_device    "default"
  mixer_control   "PCM"
  mixer_index     "0"
}
',
  }
}
