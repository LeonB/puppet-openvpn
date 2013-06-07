# Class: openvpn::params
#
# This class defines default parameters used by the main module class openvpn
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to openvpn class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class openvpn::params {

  ### Application related parameters

  $package_name = $::operatingsystem ? {
    default => 'openvpn'
  }

  $enabled = true

}
