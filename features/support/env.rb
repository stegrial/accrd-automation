require 'allure-cucumber'
require 'capybara/cucumber'

include AllureCucumber::DSL


AllureCucumber.configure do |c|
  c.output_dir = 'allure'
  c.clean_dir = true
  c.tms_prefix = '@HIPTEST--'
  c.issue_prefix = '@JIRA++'
  c.severity_prefix = '@URGENCY:'
end

Before do
  Capybara.page.driver.browser.manage.window.resize_to(1024, 780)
end

After do |scenario|
  # Do something after each scenario.
  # The +scenario+ argument is optional, but
  # if you use it, you can inspect status with
  # the #failed?, #passed? and #exception methods.

  if scenario.failed?
    screenshot = File.open(page.save_screenshot)
    AllureCucumber::DSL.attach_file "#{scenario.name}.png", screenshot
    File.delete screenshot.path
  end
end

