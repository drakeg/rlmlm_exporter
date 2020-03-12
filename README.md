# RLMlm Exporter

[![Build Status](https://travis-ci.org/drakeg/rlmlm_exporter.svg)][travis]

[![CircleCI](https://circleci.com/gh/drakeg/rlmlm_exporter.svg?style=svg)](https://circleci.com/gh/drakeg/rlmlm_exporter)
[![Docker Pulls](https://img.shields.io/docker/pulls/drakeg/rlmlm_exporter.svg?maxAge=604800)][hub]
[![GoDoc](https://godoc.org/github.com/drakeg/rlmlm_exporter?status.svg)](https://godoc.org/github.com/drakeg/rlmlm_exporter)
[![Coverage Status](https://coveralls.io/repos/github/drakeg/rlmlm_exporter/badge.svg?branch=master)](https://coveralls.io/github/drakeg/rlmlm_exporter?branch=master)
[![Go Report Card](https://goreportcard.com/badge/github.com/drakeg/rlmlm_exporter)](https://goreportcard.com/report/github.com/drakeg/rlmlm_exporter)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/00e03e600d5744d1a2cc21d98e2f8273)](https://www.codacy.com/app/mjtrangoni/rlmlm_exporterutm_source=github.com&amp;utm_medium=referral&amp;utm_content=mjtrangoni/rlmlm_exporter&amp;utm_campaign=Badge_Grade)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://raw.githubusercontent.com/drakeg/rlmlm_exporter/master/LICENSE)
[![StyleCI](https://github.styleci.io/repos/107779392/shield?branch=master)](https://github.styleci.io/repos/107779392)

[Prometheus](https://prometheus.io/) exporter for RLMlm License Manager
`lmstat` license information.

This fork is specialised for the reduced version of RLMlm License Manager bundled with installations of Klocwork. This reduced bundle contains lmstat as a independent tool, instead of the lmutil lmstat tool used by the parent of this fork.

NOTE: The RLMLM Exporter currently builds only on Linux. Windows builds are a WIP. You will need to modify the Makefile to build in Windows.

## Getting

```
$ go get github.com/drakeg/rlmlm_exporter
```

## Building

```
$ cd $GOPATH/src/github.com/drakeg/rlmlm_exporter
$ make
```

## Configuration

This is an illustrative example of the configuration file in YAML format.

```
# RLMLM Licenses to be monitored.
---
licenses:
  - name: app1
    license_file: /usr/local/rlmlm/licenses/license.dat.app1
    features_to_exclude: feature1,feature2
    monitor_users: True
    monitor_reservations: True
  - name: app2
    license_server: 28000@host1,28000@host2,28000@host3
    features_to_include: feature5,feature30
    monitor_users: True
    monitor_reservations: True
```

Notes:

 1. It is possible to define a license with a path in `license_file`, that has to
 be readable from the exporter instance, **or** with `license_server` in a
 `port@host` combination format.
 2. You can exclude some features from exporting with `features_to_exclude`,
 **or** export some defined and exclude the rest with `feature_to_include`.

## Running

```
$ ./rlmlm_exporter --path.lmutil="/klocwork/3rdparty/bin/lmstat" <flags>
```

### Docker images

Docker images are available on,

 1. [Docker](https://hub.docker.com/r/drakeg/rlmlm_exporter/).
    `$ docker pull drakeg/rlmlm_exporter`

You can launch a *rlmlm_exporter* container with,

```
$ docker run --name rlmlm_exporter -d -p 9319:9319 --volume $LMUTIL_LOCAL:/usr/bin/rlmlm/ --volume $CONFIG_PATH_LOCAL:/config $DOCKER_REPOSITORY --path.lmutil="/usr/bin/rlmlm/lmstat" --path.config="/config/licenses.yml"
```

Metrics will now be reachable at http://localhost:9319/metrics.

## What's exported?

 * `lmstat -v` information.
 * `lmstat -c license_file -a` or `lmstat -c license_server -a`
   license information.
 * `lmstat -c license_file -i` or `lmstat -c license_server -i`
   license features expiration date.

## Dashboards

 1. [Grafana Dashboard](https://grafana.com/dashboards/3854) This is for FlexLM 

## Contributing

Refer to [CONTRIBUTING.md](https://github.com/drakeg/rlmlm_exporter/blob/master/CONTRIBUTING.md)

## License

Apache License 2.0, see [LICENSE](https://github.com/drakeg/rlmlm_exporter/blob/master/LICENSE).

[travis]: https://travis-ci.org/mjtrangoni/rlmlm_exporter
[hub]: https://hub.docker.com/r/mjtrangoni/rlmlm_exporter/
[quay]: https://quay.io/repository/mjtrangoni/rlmlm_exporter
