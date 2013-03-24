class openvpn::package {

	package  { $openvpn::package_name:
		ensure => $openvpn::ensure,
	}

}
