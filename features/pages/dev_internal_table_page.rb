# encoding: UTF-8

require_relative '../../helpers/http_helper'
require_relative '../../features/support/utils'
require_relative 'accr_number_page'

require 'capybara'

include Search_number
include HTTPHelper
include Utils


module Dev_internal_table

  def open_dev_table_page(user)
    begin
      url = "/accrd-ui/accr/ul?ad-token=#{HTTPHelper.get_token user}"
      # puts url
      visit url
      page.should have_xpath("//div[contains(@class, 'accrd-order-row__data')]")
    rescue
      raise 'Не удалось открыть страницу со сводной таблицей для внутреннего пользования'
    end
  end

  def press_choose_comp_button
    begin
      find(:xpath, "//button[contains(., 'Выбор компании')]").click
    rescue
      raise 'Не удалось нажать на кнопку - Выбор компании'
    end
  end

  def clear_comp_checkboxes(list_companies)
    comp = list_companies.split(/,/)
    comp.each do |i|
    find(:xpath, "//span[@class='checkbox__text' and contains(., '#{i}')]").click
    end
  end

  def check_comp_info_absent(comp_name)
    page.should_not have_xpath("//div[contains(@class, 'accrd-order-row__data')and contains(., '#{comp_name}')]")
  end

  def check_comp_info_present(comp_name)
    page.should have_xpath("//div[contains(@class, 'accrd-order-row__data')and contains(., '#{comp_name}')]")
  end

  def press_disclose_button
    var = $new_generated_accr_number
    xpath = "//div[@class='accrd-order-row__data' and contains(., '#{var}')]//button[contains(., 'Раскрыть')]"
    find(:xpath, xpath).click
  end

  def check_send_button_disabled
    page.should have_xpath("//button[contains(., 'Отправить')and @disabled]")
  end

  def check_send_button_absent
    var = $new_generated_accr_number
    xpath = "//div[@class='accrd-order-row__data' and contains(., '#{var}')]//button[contains(., 'Раскрыть')]"
    page.should_not have_xpath(xpath)
  end


end