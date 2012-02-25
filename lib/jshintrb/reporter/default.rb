module Jshintrb
  module Reporter
    class Default

      def format errors
        result = ''
        errors.each do | error |
          result += 'line ' + error["line"].to_s + ', col ' +
            error["character"].to_s + ', ' + error["reason"].to_s + '\n'
        end
        result
      end

    end
  end
end