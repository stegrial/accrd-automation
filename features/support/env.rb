require 'allure-cucumber'
require 'capybara/cucumber'

include AllureCucumber::DSL


AllureCucumber.configure do |c|
  c.output_dir = 'allure'
  c.clean_dir = true
end


After do |scenario|
  # Do something after each scenario.
  # The +scenario+ argument is optional, but
  # if you use it, you can inspect status with
  # the #failed?, #passed? and #exception methods.


  if scenario.failed?
    path = page.save_screenshot
    puts "path to attach #{path}"
    attach_file "screenshot.png Screenshot", path
  end
end

