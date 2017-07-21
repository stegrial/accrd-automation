require_relative '../../helpers/http_helper'
require_relative '../../features/support/utils'
require 'capybara'


include HTTPHelper
include Utils

module Commenting

  def open_accr_commenting_page(user)
    url = "/disclose/#{$new_generated_accr_number}?token=#{HTTPHelper.get_token user}"
    puts url
    visit url
  end

  def press_send_button
    find(:xpath, "//button[contains(., 'Отправить')]").click
  end

  def date_compare_statement(year, month, day)
    current_date = "#{year}-#{month}-#{day}"
    xpath = "//div[contains(@class, 'comment')]//span[@class='label__inner' and contains(., '#{current_date}')]"
    page.should have_xpath(xpath)
  end

  def enter_comment(comment_text)
    find(:xpath, "//input[@class='input__control']").set(comment_text)
  end

end
