# wywy/fluentd Puppet Module

[![GitHub version](https://badge.fury.io/gh/wywy%2Fpuppet-fluentd.svg)](https://github.com/wywy/puppet-fluentd)
[![Build Status](https://travis-ci.org/wywy/puppet-fluentd.svg?branch=master)](https://travis-ci.org/wywy/puppet-fluentd)



#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with fluentd](#setup)
1. [Usage](#usage)
  * [Configuration](#configuration)
    * [Parameters](#parameters)
    * [Source](#source)
    * [Filter](#filter)
    * [Match](#match)
    * [Match Store](#match-store)
  * [Plugin Installation](#plugin-installation)
  * [Requirements](#requirements)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)
1. [License](#license)

## Description

The fluentd module sets up fluentd (td-agent) and manages configuration files.

**This module only supports fluentd from version 2**.

## Setup

This will install the latest version of fluentd

```puppet
include '::fluentd'
```

## Usage

**By default this module doesn't configure any sources, matches or filters.** The section below describes how to configure these.

### Configuration

#### Parameters

`repo_manage`

  Include repository to install recent fluentd (td-agent) from.
  **Default:** 'true'

`package_ensure`

  Package ensure.
  **Default:** 'installed'

`package_name`

  Package name.
  **Default:** 'td-agent'

`package_install_options`

  Package install options.
  **Default:** '[]'

`service_manage`

  Defines if the service should be managed by puppet.
  **Default:** 'true'

`service_name`

  Name of the service.
  **Default:** 'td-agent'

`service_ensure`

  Service ensure.
  **Default:** 'running'

`service_enable`

  Defines if the service should be enabled.
  **Default:** 'true'

`config_path`

  Path to configuration files
  **Default:** '/etc/td-agent'
  
`config_dir`

  Configuration directory name
  **Default:** '${config_path}/conf.d'

`config_file`

  Default configuration file name
  **Default:** '${config_path}/td-agent.conf'

`conf_dir_manage`

  Exclusively handle config files into fluentd::conf_dir. Other files not created by puppet, will be deleted
  **Default:** 'false'

`user_manage`

  Defines if the user should be manage, which will add the user
  to groups defined in `user_groups`.
  For example to be able to view the /var/log directory with group adm
  **Default:** 'true'

`user_name`

  **Default:** 'td-agent'

`user_group`

  **Default:** 'td-agent'

`user_groups`

  **Default:** '["adm"]'

#### Source
```puppet
::fluentd::source { 'test':
  priority => 10,
  config   => {
    'type'   => 'tail',
    'format' => 'json',
    'path'   => '/var/log/test-application/*.json',
    'parse'  => {
      'type'       => 'regexp',
      'expression' => '^(?<name>[^ ]*) (?<user>[^ ]*) (?<age>\d*)$'
    },
    'storage'=> {
      'type'   => 'local',
      'path'   => 'test.pos'
    },
    'tag'    => 'application.test'
  }
}
```
**creates:**
```
/etc/td-agent/conf.d/10-source-test.conf
<source>
  type tail
  format json
  path /var/log/test-application/*.json
  <parse>
    type regexp
    expression ^(?<name>[^ ]*) (?<user>[^ ]*) (?<age>\d*)$
  </parse>
  <storage>
    type local
    path test.pos
  </storage>
  tag application.test
</source>
```
#### Filter
```puppet
::fluentd::filter { 'test':
  priority => 20,
  pattern  => '*.test',
  config   => {
    'type'   => 'record_transformer',
    'record' => {
      'hostname' => '${hostname}'
    }
  }
}
```
**creates:**
```
/etc/td-agent/conf.d/20-filter-test.conf
<filter *.test>
  type record_transformer
  <record>
    hostname ${hostname}
  </record>
</filter>
```
#### Match
```puppet
::fluentd::match { 'test':
  priority => 30,
  pattern  => '*.test',
  config   => {
    'flush_interval' => '30s',
    'type'           => 'secure_forward',
    'secure'         => 'yes',
    'shared_key'     => 'my_shared_key',
    'self_hostname'  => 'instance.test.com',
    'ca_cert_path'   => '/path/to/ca.cert',
    'server'        => [{
      'host' => 'test.server.com',
    }]
  }
}
```
**creates:**
```
/etc/td-agent/conf.d/30-match-test.conf
<match *.test>
  flush_interval 30s
  type secure_forward
  secure yes
  shared_key my_shared_key
  self_hostname instance.test.com
  ca_cert_path /path/to/ca.cert
  <server>
    host test.server.com
  </server>
</match>
```
### Match Store
```puppet
::fluentd::match { 'test':
  priority => 30,
  pattern  => '*.test',
  config   => {
    'type'  => 'copy',
    'store' => [
      {
        'type'           => 'elasticsearch',
        'logstashformat' => true,
        'hosts'          => '172.20.10.17:9200',
        'flush_interval' => '30s',
      },
      {
        'type' => 'file',
        'path' => '/tmp/td-agent-debug.log',
      }
    ]
  }
}
```
**creates:**
```
/etc/td-agent/conf.d/30-match-test.conf
<match *.test>
  type copy
  <store>
    type elasticsearch
    logstash_format true
    hosts 172.20.10.17:9200
    flush_interval 30s
  </store>
  <store>
    type file
    path /tmp/crs
  </store>
</match>
```

### Plugin Installation

This module gives you the possibility to install plugins as gem or files.

**gem installation**
```puppet
::fluentd::plugin { 'fluent-plugin-elasticsearch':
  type => 'gem',
  ensure => '0.1.3'
}
```
**file installation**
```puppet
::fluentd::plugin { 'fluent-plugin-elasticsearch':
  type   => 'file',
  source => 'puppet:///path/to/plugin'
}
```

### Requirements

Modules:
* puppetlabs/apt >= 4.0.0

## Limitations
This module has been built on and tested against Puppet 4.6 and higher.

The module has been tested on:

* Ubuntu 16.04

Testing on other platforms has been light and cannot be guaranteed.

## Development

### Running the test suite

To run the tests install the ruby dependencies with `bundler` and execute
`rake`:

```
bundle install --path vendor/bundle
bundle exec rake spec
bundle exec rake lint
bundle exec rake beaker BEAKER_set=ubuntu-server-1404-x64
bundle exec rake beaker BEAKER_set=ubuntu-server-1604-x64
bundle exec rake beaker BEAKER_set=debian-60-x64
bundle exec rake beaker BEAKER_set=debian-78-x64
bundle exec rake beaker BEAKER_set=debian-82-x64
bundle exec rake beaker BEAKER_set=centos-66-x64
bundle exec rake beaker BEAKER_set=centos-70-x64
```

## License

Copyright 2017 ATVAG GmbH

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

This Puppet module is being actively maintained by some fellow puppeteers at [wywy](http://wywy.com/).
