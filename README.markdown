# puppet-php

puppet-php is a puppet module to manage PHP on your systems.
You can manage the CLI, Apache and FPM version of PHP.

## How to use

### CLI
```include php```

### Apache
```include php::apache2```

### FPM
```include php::fpm```

### Install additional modules and use the config from package
```php::module { "snmp": 
    notify  => [ Class["php::fpm::service"], Service["apache"], ],
}```

This will install the PHP SNMP module and notifies FPM and Apache about the change.
You're also able to set ```require => Foo["Bar"]``` if you need anything else, like sources lists before.

### Install a module and use a file from puppet server for the config
```php::module { "snmp":
    source => "puppet:///files/php/conf.d/",
    notify => Class["php::fpm::service"],
}```

### Install a module and use a template for the config
```php::module { "snmp":
    content => "php/conf.d/",
    notify  => Service["apache"],
}```

### Additional config snippets
```php::conf { "global":
    source => "puppet:///files/php/global.ini",
}```

### Extra config (e.g. browscap)
```php::extra { "lite_php_browscap":
    source  => "puppet:///files/php/extra/lite_php_browscap.ini",
    require => Php::Conf["browscap"],
    notify  => Class["php::fpm::service"],
}```

## Config files
If a module needs some configuration, you have 3 different options to place this file on the target system.

1. Config comes with the package: Puppet should leave the file as-is

2. Copy a file from the puppet fileserver to the target system

3. Use a template

### 1. Config inside package
There is nothing special. Just use php::module, php:conf or php:extra and don't specify a source or content.

### 2. File from puppet fileserver
The parameter for 'source =>' must be a directory with a trailing slash. The file must be named after the resource.

Example:
php::module['xdebug']
source => 'puppet:///files/php/conf.d/'
Real source value: 'puppet:///files/php/conf.d/xdebug.ini'

This enables you to use the following:
```
php::module { [ "xdebug", "suhosin", ]:
    source  => "puppet:///files/php/conf.d/",
    require => Apt::Sources_list["kwick-php53"],
    notify      => Class["php::fpm::service"],
}
```

### 3. Use a template
The same as in 2. is valid.

For more informations, see EXAMPLE


## Service Notification
You can define which services to notify by setting 'notify =>' on every resource.
You're able to use a module, which will trigger a notify of apache, but not of fpm.
Or no notify at all, because you're using this module only in CLI.

## Requirements
* php::apache2 requires apache module

## Notes
* php::apache2 and php::fpm both install CLI version


## TODO
* Manage FPM configuration (pools, global settings)
* Test php::apache2, everything else should work
* Document the usage of php::fpm::pool
