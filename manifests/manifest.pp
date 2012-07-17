node 'default' {
  
  include bootstrap
  
  class {'apache':
    httpd_user  => 'vagrant',
    httpd_group => 'vagrant',
  }

  apache::vhost { 'mysite.test.vt':
    port               => '80',
    docroot            => '/var/projects/mysite.test.vt',
    serveradmin        => 'rodolfo@me.org',
    configure_firewall => false,
  }

  # The apache module provides us with a new type: a2mod
  a2mod { 'rewrite':
    ensure => "present"
  }

  # MySQL
  class { 'mysql': }
  class { 'mysql::server':
      config_hash => {'root_password' => 'vagrant'}
  }
  

  # Ensure php cli & apache
  class {'php':}
  class {'php::apache2':
    memory_limit => '256M',
  }

  class {'php::pear':}
  class {'php::pecl':
    xdebug_remotehost => '192.168.33.1'
  }


}

