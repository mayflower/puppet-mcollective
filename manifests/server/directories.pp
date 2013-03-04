class mcollective::server::directories {
  include ::mcollective::params

  file { $mcollective::params::core_libdir:
    ensure => directory
  }
}
