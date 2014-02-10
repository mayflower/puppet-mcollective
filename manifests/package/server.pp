# = Class: mcollective::package::server
#
# This class will pull in the mcollective::package::stomp dependency and
# install the mcollective server. It will also add in the necessary shims
# on different platforms to ensure the server works as expected.
#
# This class will be brought in by mcollective::server and does not need to be
# directly included.
#
class mcollective::package::server {

  include mcollective::params
  require mcollective::package::stomp

  package { 'mcollective':
    ensure  => present,
  }

  case $::osfamily {
    FreeBSD: {
      # The mcollective package drops all plugins in /usr/local/share/mcollective
      # which breaks the mcollective libdir path, which expects "${libdir}/mcollective"
      # so we patch that in with a symlink
      file { "${mcollective::params::core_libdir}/mcollective":
        ensure => link,
        target => $mcollective::params::sharedir,
        before => Service[$mcollective::params::servicename];
      }
    }
  }
}
