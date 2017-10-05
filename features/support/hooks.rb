# encoding: UTF-8

require 'capybara/cucumber'


# Set custom path for screenshots
Capybara.save_path = 'reports/screenshots'


Before do
  $dunit ||= false # have to define a variable before we can reference its value
  return $dunit if $dunit # bail if $dunit TRUE
  FileUtils.rm_rf(Capybara.save_path)
  $dunit = true # don't do it again.
end

After do |scenario|

  # Do print 'scenario.name', 'scenario.exception.message' after failed scenario.
  # The +scenario+ argument is optional, but
  # Attache screenshot if the scenario #failed?

  if scenario.failed?
    screenshot = File.open(page.save_screenshot)
    puts screenshot
    embed screenshot, 'image/png'
  end
end




