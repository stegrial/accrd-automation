# encoding: UTF-8

require 'capybara/cucumber'


# Set custom path for screenshots
Capybara.save_path = 'reports/screenshots'

After do |scenario|

  # Do print 'scenario.name', 'scenario.exception.message' after failed scenario.
  # The +scenario+ argument is optional, but
  # Attache screenshot if the scenario #failed?

  if scenario.failed?
    screenshot = File.open(page.save_screenshot)
    embed screenshot, 'image/png'
  end
end




