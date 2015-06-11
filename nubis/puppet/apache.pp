# Define how apache should be installed and configured.
# This uses the puppetlabs-apache puppet module [0].
#
# [0] https://github.com/puppetlabs/puppetlabs-apache
#

$vhost_name = 'kibana3'
$install_root = '/opt/kibana3/src'
$port = 80

class {
    'apache':
        default_mods        => true,
        default_vhost       => false,
        default_confd_files => false;
    'apache::mod::remoteip':
        proxy_ips => [ '127.0.0.1', '10.0.0.0/8' ];
}

apache::vhost { $::vhost_name:
    port                        => $port,
    default_vhost               => true,
    docroot                     => $::install_root,
    docroot_owner               => 'ubuntu',
    docroot_group               => 'ubuntu',
    block                       => ['scm'],
    setenvif                    => 'X_FORWARDED_PROTO https HTTPS=on',
    access_log_format           => '%a %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-agent}i\"',
}
