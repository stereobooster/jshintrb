module Jshintrb
  module Reporter
    class Default

      def format(errors, file)

        # Skip strange errors
        errors.delete_if do |err|
          err['reason'] =~ /^Redefinition of / || err['reason'] =~ /Expected '{' and instead saw/
        end
        return '' if errors.size == 0

        result = ''
        indent = file ? '  ' : ''

        errors.each do |error|
          if error.nil? then
            result += indent + 'fatal error'
          else
            result += indent + bold('line ' + error["line"].to_s + ', col ' +
              error["character"].to_s + ', ' + error["reason"].to_s) + "\n" +
              gray(error["evidence"].to_s) + "\n"
          end
        end

        if file && result.size > 0 then
          result = cyan('file: ' + file) + "\n" + result
        end

        result
      end

      def bold (text)
        "\033[1m#{text}\033[22m"
      end

      def gray (text)
        "\033[37m#{text}\033[0m"
      end

      def cyan (text)
        "\033[36m#{text}\033[0m"
      end

    end
  end
end