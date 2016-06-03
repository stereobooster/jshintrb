# encoding: UTF-8
require 'spec_helper'

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
      expect(Jshintrb.lint(source, option => false).length).to eq(0)
      expect(Jshintrb.lint(source, option => true).length).to eq(1)
    end

    options.each do |option, source|
      expect(Jshintrb.lint(gen_file(source, option, false)).length).to eq(0)
      expect(Jshintrb.lint(gen_file(source, option, true)).length).to eq(1)
    end
  end

  it "supports globals" do
    source = "foo();"
    expect(Jshintrb.lint(source, :defaults, [:foo]).length).to eq(0)
    expect(Jshintrb.lint(source, :defaults).length).to eq(1)
  end

  it "supports .jshintrc" do
    basedir = File.join(File.dirname(__FILE__), "fixtures")
    source = "var hoge;"
    Dir.chdir basedir do
      expect(Jshintrb.lint(source, :jshintrc).length).to eq(1)
    end
  end

  it "supports globals from .jshintrc" do
    basedir = File.join(File.dirname(__FILE__), "fixtures")
    source = "foo();"
    Dir.chdir basedir do
      expect(Jshintrb.lint(source, :jshintrc).length).to eq(0)
    end
  end

  describe "Jshintrb#report" do
    it "accepts a single argument" do
      expect { Jshintrb.report('var working = false;') }.to_not raise_error
    end
  end

end
