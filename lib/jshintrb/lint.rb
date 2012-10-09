# encoding: UTF-8

require "execjs"
require "multi_json"

module Jshintrb

  class Lint
    Error = ExecJS::Error

    # Default options for JSHint
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

    # @param [Hash, Symbol, nil] options If you pass :defaults
    # @param [Array, nil] globals
    def initialize(options = nil, globals = nil)

      if options == :defaults
        @options = MultiJson.dump(DEFAULTS)
      elsif options.instance_of?(Hash)
        @options = MultiJson.dump(options)
      elsif options.nil?
        @options = nil
      else
        raise ArgumentError, "Expecting hash or :defaults for options. Instead get #{options}"
      end

      if globals.instance_of?(Array)
        @globals = Hash[*globals.product([false]).flatten]
        @globals = MultiJson.dump(@globals)
      elsif globals.nil?
        @globals_hash = nil
      else
        raise ArgumentError, "Expecting array for globals. Instead get #{globals}"
      end

      @context = ExecJS.compile(File.open(SourcePath, "r:UTF-8").read)
    end

    # @param [IO, String] source
    # @return [Array] Array of Hashes
    def lint(source)
      str = source.respond_to?(:read) ? source.read : source.dup
      raise ArgumentError, "Expecting String or IO for source. Instead get #{source}" unless str.instance_of?(String)

      str = MultiJson.dump(str)
      js = []
      if @options.nil? and @globals.nil?
        js << "JSHINT(#{str});"
      elsif @globals.nil?
        js << "JSHINT(#{str}, #{@options});"
      elsif @options.nil? and !@globals.nil?
        js << "JSHINT(#{str}, null, #{@globals});"
      else
        js << "JSHINT(#{str}, #{@options}, #{@globals});"
      end
      js << "return JSHINT.errors;"

      @context.exec js.join("\n")
    end

  end
end
