include ::fluentd

fluentd::install_plugin {
    'es':
        plugin_type => 'gem',
        plugin_name => 'fluent-plugin-elasticsearch',
}

fluentd::configfile { 'collector': }
fluentd::source { 'forwarder':
    configfile => "collector",
    type       => "forward",
}
