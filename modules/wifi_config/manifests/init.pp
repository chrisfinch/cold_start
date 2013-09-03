class wifi_config {
  group { "wifi_config":
    ensure => present,
  }

  Package { ensure => "installed" }

  package { "vim": }
  package { "screen": }
  package { "git": }
  package { "build-essential": }

  include ruby
  include network
  include wpa_cli_web
  include dnsmasq
  include nginx
}
