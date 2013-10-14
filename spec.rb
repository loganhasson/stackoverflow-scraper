require_relative './spec/spec_helper'

Dir.foreach(".") do |file|
  next if file.start_with?('.')
  if File.directory?("./#{file}")
    Dir.foreach("./#{file}") do |spec|
      next if spec.start_with?('.')
      require "./#{file}/#{spec}" if spec.end_with?("spec.rb")
    end
  end
end