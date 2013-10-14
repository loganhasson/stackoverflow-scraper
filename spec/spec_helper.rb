require_relative '../lib/database'
require_relative '../lib/scraper'
require_relative '../lib/discussion'

Dir.foreach("lib") do |file|
  next if file.start_with?('.')
  require "#{file}" if file.end_with?(".rb")
end