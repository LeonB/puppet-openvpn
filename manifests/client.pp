define openvpn::client(
  $p12,
  $server     = $name,
  $ta_key     = undef,
  $tls_remote = undef,
  $hwaddress  = undef,
  $autostart  = false,
) {

  $directory_ensure = $openvpn::ensure ? {
    present => directory,
    default => $openvpn::ensure
  }

  file { "/etc/openvpn/${server}.conf":
    ensure  => $openvpn::ensure,
    owner   => root,
    group   => root,
    mode    => '0400',
    content => template('openvpn/client.conf.erb'),
    require => Class['openvpn'],
    notify  => Class['openvpn::service'],
  }

  file { "/etc/openvpn/certs/${server}/":
    ensure  => $directory_ensure,
    force   => true,
    owner   => root,
    group   => root,
    mode    => '0400',
    require => Class['openvpn'],
    notify  => Class['openvpn::service'],
  }

  file { "/etc/openvpn/certs/${server}/${::fqdn}.p12":
    ensure  => $openvpn::ensure,
    owner   => root,
    group   => root,
    mode    => '0400',
    source  => $p12,
    require => Class['openvpn'],
    notify  => Class['openvpn::service'],
  }

  if $ta_key {
    file { "/etc/openvpn/certs/${server}/ta.key":
      ensure  => $openvpn::ensure,
      owner   => root,
      group   => root,
      mode    => '0400',
      source  => $ta_key,
      require => Class['openvpn'],
      notify  => Class['openvpn::service'],
    }
  }

  if $autostart {
    concat::fragment { "openvpn.default.autostart.${server}":
      content => "${server} ",
      target  => '/etc/default/openvpn',
      order   => 10,
    }
  }

}
