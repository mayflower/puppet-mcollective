# = Define: mcollective::plugin
#
# Installs mcollective plugins
#
# == Parameters
#
# [*name*]
#
# The type and name of the plugin. Must be in the form of
# <plugin type>/<plugin name>.
#
# [*has_ddl*]
#
# Whether the plugin has a DDL that should be installed alongside the plugin.
#
# * default: false
#
# [*module*]
#
# The module to use when sourcing files.
#
# * default: mcollective
#
# [*source*]
#
# Whether to install from package or puppet fileserver.
#
# == Examples
#
#
#    # Install the `puppetd` and `service` applications. This would normally
#    # only be applied to clients.
#    mcollective::plugin {'application/puppetd': }
#    mcollective::plugin {'application/service': }
#
#    # Install the `registration` agent to monitor mcollective server
#    # connectivity. This would probably be installed on a monitor host.
#    mcollective::plugin {'agent/registration':   has_ddl => false }
#
#    # Install a set of common mcollective agents that are useful on most
#    # nodes. This will also install the DDL for these agent plugins
#    # everywhere.
#    mcollective::plugin {'agent/puppetd':   has_ddl => true }
#    mcollective::plugin {'agent/puppetca':  has_ddl => true }
#    mcollective::plugin {'agent/puppetral': has_ddl => true }
#    mcollective::plugin {'agent/service':   has_ddl => true }
#    mcollective::plugin {'agent/package':   has_ddl => true }
#
#    # Install a 3rd party agent plugin and DDL. The backing agent and ddl
#    # files will be in `modules/puppet/files/plugins/agent/deploy.{rb,ddl}`
#    mcollective::plugin {'agent/deploy': has_ddl => true, module => 'puppet' }
#
define mcollective::plugin(
  $has_ddl = false,
  $module = 'mcollective',
  $source = 'puppet',
) {
  if $source == 'puppet' {
    $real_resource_params = {
      has_ddl => $has_ddl,
      module  => $module
    }
  } else {
    $real_resource_params = {}
  }

  $resource_params = { "${name}" => $real_resource_params }
  create_resources("mcollective::plugin::${source}", $resource_params)
}
