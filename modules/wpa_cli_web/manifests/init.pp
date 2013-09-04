class wpa_cli_web {

  package { 'git':
    ensure => installed,
  }

  vcsrepo { "":
    ensure => latest,
    provider => git,
    require => [ Package["git"] ],
    source => "http://github.com/chrisfinch/wifi-configuration.git",
    revision => 'master'
  }

  file { '/etc/init.d/wpa_cli_web':
    content => template('wpa_cli_web/wpa_init_d.erb'),
    mode => 755,
  }

  service { "wpa_cli_web":
    ensure => stopped,
    enable => true,
    require => [Package["wpa_cli_web"], File["/etc/init.d/wpa_cli_web"]],
  }
}
