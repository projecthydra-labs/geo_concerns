# Geo Concerns
[![Build Status](https://travis-ci.org/projecthydra-labs/geo_concerns.svg)](https://travis-ci.org/projecthydra-labs/geo_concerns)
[![Coverage Status](https://coveralls.io/repos/github/projecthydra-labs/geo_concerns/badge.svg?branch=master)](https://coveralls.io/github/projecthydra-labs/geo_concerns?branch=master)
[![API Docs](http://img.shields.io/badge/API-docs-blue.svg)](http://www.rubydoc.info/github/projecthydra-labs/geo_concerns)

Rails application for developing Hydra Geo models. Built around Curation Concerns engine.

* [Poster from Hydra Connect 2015](https://drive.google.com/file/d/0B5fLh2mc4FCbOUpWaTFOVmI4Nkk/view?pli=1)
* [Current GeoConcerns diagram](https://github.com/projecthydra-labs/geo_concerns/raw/master/docs/pcdm-geo-model.pdf)


## Dependencies

* [GDAL](http://www.gdal.org/)
    * You can install it on Mac OSX with `brew install gdal`.
    * On Ubuntu, use `sudo apt-get install gdal-bin`.
    
## Installation

Execute:

```
$ bundle install
```

Then:

```
$ rake db:migrate
$ rake server:development
```

## Testing

```
$ rake ci
```

To run tests separately:

```
$ rake server:test
```

Then, in another terminal window:


```
$ rake spec
```
