include ::fluentd
fluentd::configfile { 'collector': }
fluentd::source { 'forwarder':
    configfile => "collector",
    type       => "forward",
}
