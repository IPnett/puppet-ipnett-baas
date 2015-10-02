# IPnett BaaS enroller
class ipnett_baas::enroll (

  # base64-encoded access token, e.g., created using
  # echo -n $access_key:$secret_key | openssl enc -e -base64
  $access_token      = undef,

  $hostname          = $::fqnd,
  $host_description  = $::fqdn,
  $mail_address      = undef,
  $costcenter        = '1000',

  $compression       = true,
  $deduplication     = true,
  $encryption        = false,

  $platform          = undef,
  $application       = 'filesystem',

)
{
  validate_string($access_token)

  validate_string($hostname)
  validate_string($host_description)
  validate_string($mail_address)
  validate_string($costcenter)

  validate_bool($compression)
  validate_bool($deduplication)
  validate_bool($encryption)

  if ($platform) {
    validate_string($platform)
  } else {
    # magic
  }

  validate_string($application)

  package { 'ipnett-baas-setup':
    ensure => 'latest';
  }

  exec { 'ipnett-baas-setup':
    command  => "/usr/bin/ipnet-baas-setup -H $hostname -a $application -t $access_token -c $costcenter -i $host_description -m $mail_address -p $platform",
    creates  => "/opt/tivoli/tsm/client/ba/bin/dsm.sys",
    timeout  => 400,
    requires => Package["ipnett-baas-setup"],
  }
}
