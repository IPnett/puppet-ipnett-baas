# IPnett BaaS repository
class ipnett_baas::repo {
  file {
    '/etc/yum.repos.d/ipnett-baas.repo':    
      ensure  => file,
      mode    => '0444',
      content => template('ipnett_baas/ipnett-baas.repo.erb');
  }
}
