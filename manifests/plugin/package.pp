define mcollective::plugin::package {
  include mcollective::params
  include mcollective::server

  if $name =~ /^mcollective-/ {
    $real_packages = $name
  } else {
    $real_packages = [
      "mcollective-${name}-common",
      "mcollective-${name}-client",
      "mcollective-${name}-agent",
    ]
  }

  package { $real_packages:
    ensure => present,
    notify => Service[$mcollective::params::servicename]
  }
}