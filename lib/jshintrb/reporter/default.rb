module Jshintrb
  module Reporter
    class Default

      # @param [Array] errors Array of Hashes returned by Jshintrb::Lint.lint
      # @param [String, nil] file
      # @return [String]
      def format (errors, file = nil)
        result = ''
        indent = file ? '  ' : ''

        errors.each do |error|
          if error.nil?
            result += "#{indent} fatal error\n"
          else
            result += "#{indent} line #{error['line']}, col #{error['character']}, #{error['reason']}\n"
          end
        end

        file and result.size > 0 ? "file: #{file}\n#{result}" : result
      end

    end
  end
end