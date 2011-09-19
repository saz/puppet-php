# puppet-php

puppet-php is a puppet module to manage PHP on your systems.
You can manage the CLI, Apache and FPM version of PHP.

## How to use

#### CLI
	include php

#### Apache
	include php::apache2

#### FPM
	include php::fpm

*php::apache2* and *php::fpm* will include php automatically.



### Installing PHP modules

The easiest way of installing additional PHP modules is using packages
from your distribution and the bundled configuration files.

```
	php::module { 'snmp': 
		notify => [ Class['php::fpm::service'], Service['apache'], ],
	}
```

Multiple modules are possible, too.

```
    php::module { ['snmp', 'xdebug', ]:
        notify => Class['php::fpm::service'],
    }
```

Sometimes, modules require some custom configuration settings and you
want to retrieve a file from the server.

```
    php::module { 'snmp':
        source => true,
        notify => Class['php::fpm::service'],
    }
```

At first, this looks a bit strange. If you set `source` to `true`,
a file will be fetched from multiple sources:

1. 'puppet:///files/$fqdn/etc/php5/conf.d/module.ini'
2. 'puppet:///files/$hostgroup/etc/php5/conf.d/module.ini'
3. 'puppet:///files/$domain/etc/php5/conf.d/module.ini'
4. 'puppet:///files/global/etc/php5/conf.d/module.ini'

The first source that exists will be used.
This makes it quite easy to have different files for different systems without
duplicating any of your definitions.

This is even possible, if you manage multiple modules!


But if you really need to set a different source, this is possible, too.

```
    php::module { 'snmp':
        source => 'puppet:///files/different/path/to/the/file/',
        notify => Class['php::fpm::service'],
    }
```

To make it still possible, to have multiple modules, this should point to a directory.
In this directory, place files named *module.ini*.

**Do not forget to add a trailing slash!**



Sometimes you may need to use a template instead of a file.

```
    php::module { 'snmp':
        content => 'php5/conf.d/',
        notify  => Class['php::fpm::service'],
    }
```

You can define multiple modules, excactly like before with sources.
The only difference is, that, at the moment, only one template per module will be used.

Place your templates inside your template directory and name them 'module.ini.erb'



### Additional configuration settings

You can place additional configuration files in the 'conf.d' directory as follows:

```
    php::conf { "global":
        source => "puppet:///files/php/global.ini",
    }
```

The same source fetching rules applies as in the 'modules' section.



### Extra configuration files

Those configuration files will be placed inside an 'extras' directory in your configuration root.
This is to make sure, that those configuration files are not parsed by PHP by default.

```
    php::extra { 'lite_php_browscap':
        source  => 'puppet:///files/php5/extra/lite_php_browscap.ini',
        require => Php::Conf['browscap'],
        notify  => Class['php::fpm::service'],
    }
```

You can use a template, too:

```
    php::extra { 'lite_php_browscap':
        content => 'php5/conf.d/',
        require => Php::Conf['browscap'],
        notify  => Class['php::fpm::service'],
    }
```

Again, the same source fetching rules applies as in the 'modules' section.

For more informations, see EXAMPLE



### Service Notification
On every resource, you can define, what other service should be notified.
If you run PHP within Apache, you want to notify Apache of any changes or
FPM should be notified and restarted to make the new configuration work.



### Requirements
* php::apache2 requires *apache* module



### TODO
* Manage FPM configuration (global settings)
* Document the usage of php::fpm::pool
