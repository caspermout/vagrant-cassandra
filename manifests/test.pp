class { 'cassandra':
    initial_token => '42231795865117307932921825928971026432',
    cluster_name  => 'YourCassandraCluster',
    seeds         => [ '127.0.0.1', ],
}
