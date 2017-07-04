# task :test do
#   system 'cucumber'
# end

task :default do
  system 'cucumber'
end

task :validate do
  system 'gem install rubocop'
  system 'rubocop'
end

task :purge do
  rm(Dir['reports/screenshots/screenshot*'])
  rm(Dir['reports/*.html'])
  remove_file('Gemfile.lock')
  puts 'Reports deleted'
end

