# encoding: UTF-8

require "jshintrb/version"
require "jshintrb/lint"
require "jshintrb/reporter/default"

module Jshintrb

  # @param [IO, String] source
  # @param [Hash, Symbol, nil] options :defaults
  # @param [Array, nil] globals
  # @return [Array] Array of Hashes
  def self.lint(source, options = nil, globals = nil)
    Lint.new(options, globals).lint(source)
  end

  # @param [IO, String] source
  # @param [Hash, Symbol, nil] options
  # @param [Array, nil] globals
  # @param [IO, nil] out Use it if you want that reporter print result ASAP instead of buffering
  # @return [String]
  def self.report(source, options = nil, globals = nil, out = nil)
    reporter = Reporter::Default.new
    linter = Lint.new(options, globals)
    report = ''
    if source.is_a?(Array)
      source.each do |src|
        raise ArgumentError, "Expected Array of Strings or String or IO. Instead get Array of #{src.class}" unless src.is_a?(String)

        errors = linter.lint(File.read(src))
        rep = reporter.format errors, src
        if out and rep.size > 0
          out.puts rep
        end
        report += rep
      end
    else
      errors = linter.lint(source)
      report = reporter.format errors
      if out
        out.puts report
      end
    end
    report
  end

end
