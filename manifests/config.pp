class openvpn::config {

  $directory_ensure = $openvpn::ensure ? {
    present => directory,
    default => $openvpn::ensure
  }

  file { '/etc/openvpn/certs/':
    ensure  => $directory_ensure,
    force   => true,
    owner   => root,
    group   => root,
    mode    => '0640',
    require => Class['openvpn'],
  }

  file { '/etc/openvpn/client_up':
    ensure  => $openvpn::ensure,
    source  => 'puppet:///modules/openvpn/client_up',
    owner   => root,
    group   => root,
    mode    => '0700',
    require => Class['openvpn'],
  }

  file { '/etc/openvpn/client_down':
    ensure  => $openvpn::ensure,
    source  => 'puppet:///modules/openvpn/client_down',
    owner   => root,
    group   => root,
    mode    => '0700',
    require => Class['openvpn'],
  }

  concat { '/etc/default/openvpn':
    owner  => root,
    group  => root,
    mode   => '0644', # rw,r,r
    warn   => true,
  }

  concat::fragment { 'openvpn.default.header':
    content => template('openvpn/default/openvpn.erb'),
    target  => '/etc/default/openvpn',
    order   => 01,
  }

  concat::fragment { 'openvpn.default.autostart.autostart_begin':
    content => 'AUTOSTART="',
    target  => '/etc/default/openvpn',
    order   => 10,
  }

  concat::fragment { 'openvpn.default.autostart.autostart_end':
    content => "\"\n",
    target  => '/etc/default/openvpn',
    order   => 99,
  }

}
