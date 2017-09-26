require 'allure-cucumber'
require 'capybara/cucumber'

include AllureCucumber::DSL

Capybara.app_host = ENV['base_url']

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

# AfterStep do
#   data_set = File.open(File.expand_path(File.dirname(__FILE__)+'../../../helpers/data_sets/create_accr_dev.yml'))
#   AllureCucumber::DSL.attach_file("create_accr_dev.yml", data_set, true)
# end

After do |scenario|
  # Do something after each scenario.
  # The +scenario+ argument is optional, but
  # if you use it, you can inspect status with
  # the #failed?, #passed? and #exception methods.

  if scenario.failed?
    screenshot = File.open(page.save_screenshot)
    AllureCucumber::DSL.attach_file("#{scenario.name}.png", screenshot, false)
    File.delete screenshot.path
  end
end
