$vhost_name = 'kibana3'
$install_root = '/opt/kibana3/src'
$port = 80

file {
    '/var/www/kibana3':
        ensure => link,
        target => $install_root,
}

class {
    'kibana3':
        config_es_port     => '80/es',
        config_es_protocol => 'http',
        config_es_server   => '"+window.location.hostname+"',
        manage_ws          => false,
}
class {
    'apache':
        default_mods        => true,
        default_vhost       => false,
        default_confd_files => false;
    'apache::mod::remoteip':
        proxy_ips => [ '127.0.0.1', '10.0.0.0/8' ];
}

include apache::mod::proxy
include apache::mod::proxy_http

apache::vhost { $::vhost_name:
    port              => $port,
    default_vhost     => true,
    docroot           => '/var/www/kibana3',
    docroot_owner     => 'ubuntu',
    docroot_group     => 'ubuntu',
    block             => ['scm'],
    setenvif          => 'X_FORWARDED_PROTO https HTTPS=on',
    access_log_format => '%a %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-agent}i\"',
    require           => File['/var/www/kibana3'],
    proxy_pass        => [
        { 'path'      => '/es',
          'url'       => 'http://127.0.0.1:9200' },
    ],
}
