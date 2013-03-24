class openvpn::config {

	augeas { "/etc/default/openvpn":
		context => '/files/etc/default/openvpn',
		changes => [
			'set AUTOSTART "all"',
		],
		notify  => Class['openvpn::service'],
	}

	file { '/etc/openvpn/keys/':
		ensure  => $openvpn::ensure ? { present => directory, default => $openvpn::ensure },
		force   => true,
		owner   => root,
		group   => root,
		mode    => 640,
		require => Class['openvpn'],
	}

}
