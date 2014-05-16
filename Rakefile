require 'bundler/gem_tasks'
require 'rake/testtask'
require 'dotenv/tasks'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = "test/*_test.rb"
end

task default: :test
task test: :dotenv
