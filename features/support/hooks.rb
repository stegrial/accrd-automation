Capybara.app_host = 'http://ufrvpndev/accrd-ui'
Capybara.default_driver = :selenium
Capybara.register_driver :selenium do |app|
  # Capybara::Selenium::Driver.new(app, browser: :chrome)
  Capybara::Selenium::Driver.new(app,
      browser: :chrome, desired_capabilities: {
          'chromeOptions' => {
              'prefs' => {
                  'download.default_directory' => File.expand_path('~/Documents/Alfabank/accrd-automation/config/saved_statements')
              }
          }
      }
  )
end


Capybara.save_path = 'reports/screenshots'
Capybara.default_max_wait_time = 20