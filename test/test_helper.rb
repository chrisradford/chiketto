require 'chiketto'
require 'dotenv'
require 'minitest/autorun'
require 'vcr'

Dotenv.load

VCR.configure do |c|
  c.cassette_library_dir = 'test/vcr'
  c.hook_into :webmock
end

if ENV['TRAVIS']
  require 'coveralls'
  Coveralls.wear!
end
