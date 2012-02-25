# jshintrb
[![Build Status](https://secure.travis-ci.org/stereobooster/jshintrb.png?branch=master)](http://travis-ci.org/stereobooster/jshintrb)

Ruby wrapper for [JSHint](https://github.com/jshint/jshint/). The main difference from [jshint](https://github.com/liquid/jshint_on_rails) it does not depend on Java. Instead, it uses [ExecJS](https://github.com/sstephenson/execjs).

## Installation

jshintrb is available as ruby gem.

    $ gem install jshintrb

Ensure that your environment has a JavaScript interpreter supported by [ExecJS](https://github.com/sstephenson/execjs). Usually, installing therubyracer gem is the best alternative.

## Usage

    require 'jshintrb'

    Jshintrb.lint(File.read("source.js"))
    # => array of warnings

    Jshintrb.report(File.read("source.js"))
    # => string

When initializing jshintrb, you can pass options

    Uglifier.new(:undef => true).compile(source)

    # Or
    Uglifier.compile(source, :undef => true)

Available options and their defaults are

    {
      :bitwise => true,
      :curly => true,
      :eqeqeq => true,
      :forin => true,
      :immed => true,
      :latedef => true,
      :newcap => true,
      :noarg => true,
      :noempty => true,
      :nonew => true,
      :plusplus => true,
      :regexp => true,
      :undef => true,
      :strict => true,
      :trailing => true,
      :browser => true
    }

## TODO

 - add rake task which will accept pattern for files
 - add color reporter
 - add more tests

