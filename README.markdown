# puppet-php

puppet-php is a puppet module to manage PHP on your systems.
It enabled you to manage the CLI version on PHP, Apache and FPM.

## How to use

### CLI
```include php```

### Apache
```include php::apache2```

### FPM
```include php::fpm```

### Install additional modules
```php::module { "snmp": }```
This will install the PHP SNMP module.
You're also able to set ```require => Foo["Bar"]``` if you need anything else, like sources lists before.

### Additional config snippets
```php::conf { "global":
    source => "puppet:///files/php/global.ini",
}```
This will install additional config snippets.

## Config files
The config files, like php.ini or module configurations in conf.d will be fetched from the following locations:
1. puppet:///files/hosts/$hostname
2. puppet:///files/hosts/$fqdn
3. puppet:///files/domains/$domain
4. puppet:///files/global/
5. undef

If there is a file installed through your packet manager and no other file is found in 1 - 4, the last one ensures,
that your file will be not deleted.

## Service Notification
* If you include php::apache2, Apache will be notified of changes
* If you include php::fpm, FPM will be notified of changes


## TODO
* Manage FPM configuration (pools, global settings)
* Test the module (ATM it is fully untested)
