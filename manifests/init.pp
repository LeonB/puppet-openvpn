class openvpn(
  $package_name  = params_lookup( 'package_name' ),
  $enabled       = params_lookup( 'enabled' ),
  ) inherits openvpn::params {

    $ensure = $enabled ? {
      true => present,
      false => absent
    }

  include openvpn::package, openvpn::config, openvpn::service
}
