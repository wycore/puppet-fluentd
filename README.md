# wywygmbh/fluentd Puppet Module

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with fluentd](#setup)
1. [Usage](#usage)
  * [Configuration](#configuration)
    * [Source](#source)
    * [Filter](#filter)
    * [Match](#match)
  * [Plugin Installation](#plugin-installation)
  * [Requirements](#requirements)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

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

#### Source
```puppet
::fluentd::source { 'test':
  priority => 10,
  config   => {
    'type'   => 'tail',
    'format' => 'json',
    'path'   => '/var/log/test-application/*.json',
    'tag'    => 'application.test'
  }
}
```
**results in:**
```
/etc/td-agent/conf.d/10-source-test.conf
<source>
    type tail
    format json
    path /var/log/test-application/*.json
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
**results in:**
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
    'servers'        => {
      'host' => 'test.server.com'
    }
  }
}
```
**results in:**
```
/etc/td-agent/conf.d/30-match-test.conf
<match *.test>
        flush_interval 30s
        type secure_forward
        secure yes
        shared_key my_shared_key
        self_hostname instance.test.com
        ca_cert_path /path/to/ca.cert
        <servers>
            host test.server.com
        </servers>
</match>
```

### Plugin Installation

This module gives you the possibility to install plugins as gem or files.

**gem installation**
```puppet
::fluentd::plugin { 'fluent-plugin-elasticsearch':
  type => 'gem'
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
* puppetlabs/apt >= 1.8.0 < 3.0.0

## Limitations
This module has been built on and tested against Puppet 3.7.5 and higher.

The module has been tested on:

* Ubuntu 12.04

Testing on other platforms has been light and cannot be guaranteed.

## Development

### Running the test suite

To run the tests install the ruby dependencies with `bundler` and execute
`rake`:

```
bundle install --path vendor/bundle
bundle exec rake spec
bundle exec rake lint
```
