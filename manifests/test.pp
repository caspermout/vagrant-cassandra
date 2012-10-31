class { 'cassandra':
    initial_token => '42231795865117307932921825928971026432',
    cluster_name  => 'YourCassandraCluster',
    seeds         => [ '127.0.0.1', ],
}

package { 'opscenter-free':
	ensure => 'present'
}

exec { "opscenterconf":
	command => "sed -i -e 's/^interface = .*$/interface = 0.0.0.0/' /etc/opscenter/opscenterd.conf",
	path    => "/usr/bin:/usr/sbin:/bin",
	unless  => "grep '^interface = 0.0.0.0$' /etc/opscenter/opscenterd.conf",
	notify  => Service['opscenterd']
}

service { 'opscenterd':
	enable => 'true',
	ensure => 'running'
}

Class['cassandra'] -> Package['opscenter-free'] -> Exec['opscenterconf'] -> Service['opscenterd']

