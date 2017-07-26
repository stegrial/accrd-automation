Capybara.app_host = 'http://ufrvpndev/accrd-ui'
Capybara.default_driver = :selenium
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end


Capybara.save_path = 'reports/screenshots'

