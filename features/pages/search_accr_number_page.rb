require_relative '../../helpers/http_helper'
require_relative '../../features/support/utils'
require 'capybara'


include HTTPHelper
include Utils

module Search_number

  def open_search_number_page(user)
    url = "/search?token=#{HTTPHelper.get_token user}"
    puts url
    visit url
  end

  def press_find_button
    find(:xpath, "//button[@data-reactid='40']").click
  end

  def enter_accr_number(number)
    find(:xpath, "//input[@data-reactid='37']").set(number)
  end


end