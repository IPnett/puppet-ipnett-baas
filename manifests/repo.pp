# IPnett BaaS repository
class ipnett_baas::repo
{
  case $::osfamily {
    'redhat': {
      $major = $::os['release']['major']
      case $major {
        '6': { $distribution = 'el6' }
        '7': { $distribution = 'el7' }
        default: { fail("Unsupported RedHat release ${major}") }
      }

      file {
        '/etc/pki/rpm-gpg/RPM-GPG-KEY-IPnett':
          ensure  => file,
          mode    => '0444',
          source => 'puppet:///modules/ipnett_baas/RPM-GPG-KEY-IPnett';

        '/etc/yum.repos.d/ipnett-baas.repo':
          ensure  => file,
          mode    => '0444',
          content => template('ipnett_baas/ipnett-baas.repo.erb');
      }

    }
    default: {
      fail("Unsupported osfamily ${::osfamily}")
    }
  }
}
