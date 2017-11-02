# encoding: UTF-8

require_relative '../../helpers/rs/http_helper'
require_relative '../../features/support/utils'
require 'capybara'

include HTTPHelper
include Utils

# This module for disclose accrd page
module DisclosePage

  # @param [String] user
  def open_disclose_page(user)
    url = "/accrd-ui/disclose/#{$saved_accrd_num}?ad-token=#{HTTPHelper.get_token user}"
    visit url
  rescue
    raise 'Не удалось открыть сводную страницу заявки'
  end

  def press_send_button
    find(:xpath, "//button[contains(., 'Отправить')]").click
  rescue
    raise 'Не удалось отправить комментарий'
  end

  # @param [Integer] year
  # @param [Integer] month
  # @param [Integer] day
  def date_compare_statement(year, month, day)
    current_date = "#{year}-#{month}-#{day}"
    xpath = "//div[contains(@class, 'comment')]//span[@class='label__inner' and contains(., '#{current_date}')]"
    page.should have_xpath(xpath)
  rescue
    raise 'Не удалось сравнить дату отправки комментария или дата не соответствует текущей'
  end

  # @param [String] comment_text
  def enter_comment(comment_text)
    find(:xpath, "//input[@class='input__control']").set(comment_text)
  rescue
    raise 'Не удалось ввести комментарий'
  end

end
