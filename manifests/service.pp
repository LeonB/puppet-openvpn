class openvpn::service {

  service { 'openvpn':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => $openvpn::enable,
    require    => Class['openvpn::package'],
  }
}
