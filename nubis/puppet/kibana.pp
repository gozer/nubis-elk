$vhost_name = 'kibana3'
$install_root = '/opt/kibana3/src'
$port = 80

class {
    'kibana3':
        config_es_port     => '9200',
        config_es_protocol => 'http',
        config_es_server   => '127.0.0.1',
        manage_ws          => false,
        before             => Class['apache'],
}
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
