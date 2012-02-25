# encoding: UTF-8

require "jshintrb/version"
require "jshintrb/lint"
require "jshintrb/reporter/default"

module Jshintrb

  def self.lint(source, options = nil)
    Lint.new(options).lint(source)
  end

  def self.report(source, options = nil)
    reporter = Reporter::Default
    errors = Lint.new(options).lint(source)
    reporter.new.format errors
  end

end