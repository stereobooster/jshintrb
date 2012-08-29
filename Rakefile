require "bundler/gem_tasks"

[:build, :install, :release].each do |task_name|
  Rake::Task[task_name].prerequisites << :spec
end

require 'submodule'
Submodule::Task.new do |t|
    t.test do
      # sudo apt-get update
      # sudo apt-get install npm
      # sudo npm -g install expresso
      expresso = "/usr/bin/expresso"
      sh "#{expresso} tests/unit/*.js"
      sh "#{expresso} tests/regression/*.js"
    end

    t.after_pull do
      cp "vendor/jshint/jshint.js", "lib/js/jshint.js"
      sh "git add lib/js/jshint.js"
    end
end

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new

task :default => :spec

#desc "Generate code coverage"
# RSpec::Core::RakeTask.new(:coverage) do |t|
  # t.rcov = true
  # t.rcov_opts = ["--exclude", "spec"]
# end
