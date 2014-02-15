# == Class: core_permission
#
# This class menages permissions for critical system files.
#
# Original example:
#   http://docs.puppetlabs.com/pe/latest/quick_writing.html
#
# Rewritten using puppen-lint.
#
# === Authors
#
# Jacopo Binosi <b4inoz@gmail.com>
#
class ppm_core_permissions {
  if $::osfamily != 'windows' {

    notify {'test':
      message => "OS_FAMILY: ${::osfamily}",
    }

    $rootgroup = $::operatingsystem ? {
      'Solaris' => 'wheel',
      default   => 'root',
    }

    $fstab = $::operatingsystem ? {
      'Solaris' => '/etc/vfstab',
      default   => '/etc/fstab',
    }

    file {'fstab':
      ensure => present,
      path   => $fstab,
      mode   => '0644',
      owner  => 'root',
      group  => $rootgroup,
    }

    file {'/etc/passwd':
      ensure => present,
      mode   => '0644',
      owner  => 'root',
      group  => $rootgroup,
    }

    file {'/etc/crontab':
      ensure => present,
      mode   => '0644',
      owner  => 'root',
      group  => $rootgroup,
    }

  }
}
