# encoding: UTF-8
require "jshintrb"

def gen_file source, option, value
  "/*jshint " + option.to_s + ": " + value.to_s + "*/\n" + source
end

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

    options.each do |option, source|
      Jshintrb.lint(gen_file(source, option, false)).length.should eq 0
      Jshintrb.lint(gen_file(source, option, true)).length.should eq 1
    end
  end

  it "supports globals" do
    source = "foo();"
    Jshintrb.lint(source, :defaults, [:foo]).length.should eq 0
    Jshintrb.lint(source, :defaults).length.should eq 1
  end

end
