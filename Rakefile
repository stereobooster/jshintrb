require "bundler/gem_tasks"

[:build, :install, :release].each do |task_name|
  Rake::Task[task_name].prerequisites << :spec
end

desc "Update git submodules"
task :git do
  sh "git submodule update --init --recursive"
  cp "vendor/jshint/jshint.js", "lib/js/jshint.js"
end

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new

task :default => :spec

#desc "Generate code coverage"
# RSpec::Core::RakeTask.new(:coverage) do |t|
  # t.rcov = true
  # t.rcov_opts = ["--exclude", "spec"]
# end

require "./lib/jshintrb/jshinttask"
Jshintrb::JshintTask.new :jshint do |t|
  t.pattern = 'vendor/jshint/tests/unit/fixtures/*.js'
  t.options = :defaults
end