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

desc "Run specs"
RSpec::Core::RakeTask.new

#desc "Generate code coverage"
# RSpec::Core::RakeTask.new(:coverage) do |t|
  # t.rcov = true
  # t.rcov_opts = ["--exclude", "spec"]
# end
