define openvpn::client(
	$server     = $name,
	$p12,
	$ta_key     = undef,
	$tls_remote = undef,
) {

	file { "/etc/openvpn/${server}.conf":
		ensure  => $openvpn::ensure,
		owner   => root,
		group   => root,
		mode    => 640,
		content => template("openvpn/client.conf.erb"),
		require => Class['openvpn'],
	}

	file { "/etc/openvpn/certs/${server}/":
		ensure  => $openvpn::ensure ? { present => directory, default => $openvpn::ensure },
		force   => true,
		owner   => root,
		group   => root,
		mode    => 640,
		require => Class['openvpn'],
	}

	file { "/etc/openvpn/certs/${server}/${fqdn}.p12":
		ensure  => $openvpn::ensure,
		owner   => root,
		group   => root,
		mode    => 640,
		source  => $p12,
		require => Class['openvpn'],
	}

	if $ta_key {
		file { "/etc/openvpn/certs/${server}/ta.key":
			ensure  => $openvpn::ensure,
			owner   => root,
			group   => root,
			mode    => 640,
			source  => $ta_key,
			require => Class['openvpn'],
		}
	}

}
