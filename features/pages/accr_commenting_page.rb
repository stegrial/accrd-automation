# encoding: UTF-8

require_relative '../../helpers/http_helper'
require_relative '../../features/support/utils'
require 'capybara'

include HTTPHelper
include Utils


module Commenting

  def open_accr_commenting_page(user)
    begin
      url = "/accrd-ui/disclose/#{$saved_accrd_num}?ad-token=#{HTTPHelper.get_token user}"
      #puts url
      visit url
    rescue
      raise 'Не удалось открыть сводную страницу заявки'
    end
  end

  def press_send_button
    begin
      find(:xpath, "//button[contains(., 'Отправить')]").click
    rescue
      raise 'Не удалось нажать на кнопку - Отправить'
    end
  end

  def date_compare_statement(year, month, day)
    begin
      current_date = "#{year}-#{month}-#{day}"
      xpath = "//div[contains(@class, 'comment')]//span[@class='label__inner' and contains(., '#{current_date}')]"
      page.should have_xpath(xpath)
    rescue
      raise 'Не удалось сравнить дату отправки комментария или дата отправки комментария не соответствует текущей'
    end
  end

  def enter_comment(comment_text)
    begin
      fill_in('disclosure-pack--comment', with: comment_text)
    rescue
      raise 'Не удалось ввести Комментарий'
    end
  end

  def trutrutru
    'Hi'
  end


end
