# encoding: UTF-8

require 'allure-cucumber'
require 'bundler/setup'
require 'selenium/webdriver'
require 'capybara'
require 'capybara/cucumber'
require 'capybara-pega'

require 'config'
require 'allure-cucumber'
require 'nokogiri'
require 'open-uri'


def makeCapabilities
  capabilities = {
      :version => '',
      :browserName => 'chrome',
      :platform => 'ANY',
      'chromeOptions': {
          'prefs': {
              'download.default_directory': File.expand_path('../../config/saved_statements/', File.dirname(__FILE__)),
              'download.directory_upgrade': true
          }
      }
  }
end

# Config
$config = YAML::load_file(File.join('config.yml'))

puts $config.to_yaml

Capybara.default_driver = :chrome
Capybara.javascript_driver = :chrome

p "Environment: #{ENV['ENV']}"

if ENV['ENV']
  $enviroment = $config['enviroments'][ENV['ENV']]

  puts 'All environments:'
  puts $enviroment.to_yaml

  puts 'Special url:'
  puts $enviroment['url']

  if ENV['ENV'] == 'dev'

    # Headless Chrome
    puts 'Headless Chrome'
    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"args" => ["--headless", "--disable-gpu", "--disable-plugins"]})
    grid = false
  else
    # Selenium Grid
    puts 'Selenium Grid'
    Capybara.default_driver = :remote_browser
    Capybara.javascript_driver = :remote_browser

    capabilities = makeCapabilities
    grid = true
  end
else
  # UI Chrome
  puts 'Chrome UI'
  $enviroment = $config['enviroments'][$config['enviroments']['default']]
  capabilities = makeCapabilities
  grid = false
end

puts "Select environment '#{$enviroment['name']}'"

# Selenium Hub
Capybara.register_driver :remote_browser do |app|


  # If the requested test environment is not registered with the selenium grid hub
  # or busy, allow enough time for the Gridlastic auto scaling
  # functionality to launch a node with the requested environment.
  #
  client = Selenium::WebDriver::Remote::Http::Default.new
  client.read_timeout = 12000 #seconds

  Capybara::Selenium::Driver.new(
      app, http_client: client,
      :browser => :remote,
      :url => $enviroment['hub_url'],
      :desired_capabilities => capabilities)
end

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(
      app,
      :browser => :chrome,
      :desired_capabilities => capabilities)
end

Capybara.default_max_wait_time = $config['capybara']['default_max_wait_time']
Capybara.app_host = $enviroment['url']


unless grid
  Capybara.current_session.driver.browser.manage.window.resize_to(
      $config['browser']['window']['width'],
      $config['browser']['window']['height'])
end

if grid
  Capybara.current_session.driver.browser.file_detector = lambda do |args|
    str = args.first.to_s
    str if File.exist?(str)
  end
end