require "bundler/gem_tasks"
require 'rake/testtask'

desc 'Default Raketask'
task :default do
  Rake::Task['test'].invoke
end

Rake::TestTask.new do |t|
  t.pattern = "spec/*_spec.rb"
end
