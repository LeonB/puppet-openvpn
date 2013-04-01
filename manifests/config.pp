class openvpn::config {

	augeas { "/etc/default/openvpn":
		context => '/files/etc/default/openvpn',
		changes => [
			'set AUTOSTART "all"',
		],
		notify  => Class['openvpn::service'],
	}

	file { '/etc/openvpn/certs/':
		ensure  => $openvpn::ensure ? { present => directory, default => $openvpn::ensure },
		force   => true,
		owner   => root,
		group   => root,
		mode    => 640,
		require => Class['openvpn'],
	}

	file { '/etc/openvpn/client_up':
		ensure => $openvpn::ensure,
		source => 'puppet:///modules/openvpn/client_up',
		owner  => root,
		group  => root,
		mode   => 700,
		require => Class['openvpn'],
	}

	file { '/etc/openvpn/client_down':
		ensure => $openvpn::ensure,
		source => 'puppet:///modules/openvpn/client_down',
		owner  => root,
		group  => root,
		mode   => 700,
		require => Class['openvpn'],
	}

}
