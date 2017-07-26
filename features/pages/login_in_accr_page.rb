require_relative '../../helpers/http_helper'
require_relative '../../features/support/utils'
require 'capybara'


include HTTPHelper
include Utils

module Login

  def open_login_page
    visit "http://ufrvpndev/accrd-ui/accr/new"
  end

  def press_login_button
    find(:xpath, "//button[@data-reactid='44']").click
  end

  def enter_login(login)
    find(:xpath, "//input[@data-reactid='33']").set(login)
  end

  def enter_password(password)
    find(:xpath, "//input[@data-reactid='41']").set(password)
  end


end