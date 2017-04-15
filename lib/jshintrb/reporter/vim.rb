module Jshintrb
  module Reporter
    class Vim

      def format errors, file
        result = ''

        errors.each do |error|
          if error.nil? then
            result += "#{file}:1: Generic error\n"
          else
            line = error["line"].to_s
            reason = error["reason"].to_s
            result += "#{file}:#{line}: #{reason}\n"
          end
        end

        result
      end

    end
  end
end
