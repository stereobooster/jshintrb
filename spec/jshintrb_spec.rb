# encoding: UTF-8
require "jshintrb"

describe "Jshintrb" do
  
  it "support options" do
    options = {
      :bitwise => "var a = 1|1;",
      :curly => "while (true)\n  var a = 'a';",
      # :eqeqeq => true,
      # :forin => true,
      # :immed => true,
      # :latedef => true,
      # :newcap => true,
      # :noarg => true,
      # :noempty => true,
      # :nonew => true,
      # :plusplus => true,
      # :regexp => true,
      :undef => "if (a == 'a') { var b = 'b'; }"
      # :strict => true,
      # :trailing => true,
      # :browser => true
    }

    options.each do |option, source|
      Jshintrb.lint(source, option => false).length.should eq 0
      Jshintrb.lint(source, option => true).length.should eq 1
    end

  end

end
