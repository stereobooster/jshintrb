# encoding: UTF-8

require "execjs"
require "multi_json"

module Jshintrb

  class Lint
    Error = ExecJS::Error

    # Default options for compilation
    DEFAULTS = {
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

    SourcePath = File.expand_path("../../js/jshint.js", __FILE__)

    def initialize(options = nil)

      if options == :defaults then
        @options = DEFAULTS.dup
      elsif options.instance_of? Hash then
        @options = options.dup
        # @options = DEFAULTS.merge(options)
      elsif options.nil?
        @options = nil
      else
        raise 'Unsupported option for Jshintrb: ' + options.to_s
      end

      @context = ExecJS.compile(File.open(SourcePath, "r:UTF-8").read)
    end

    def lint(source)
      source = source.respond_to?(:read) ? source.read : source.to_s

      js = []
      if @options.nil? then
        js << "JSHINT(#{MultiJson.encode(source)});"
      else
        js << "JSHINT(#{MultiJson.encode(source)}, #{MultiJson.encode(@options)});"
      end
      js << "return JSHINT.errors;"

      @context.exec js.join("\n")
    end

  end
end