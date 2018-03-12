# encoding: UTF-8

require_relative '../../helpers/http_helper'
require_relative '../../features/support/utils'
require_relative 'accr_number_page'

require 'capybara'

include SearchNumber
include HTTPHelper
include Utils


module Dev_internal_table

  def open_dev_table_page(user)
    begin
      url = "/accrd-ui/accr/ul?token=#{HTTPHelper.get_token user}"
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

  def clear_comp_checkboxes
    all(:xpath, "//span[@class='checkbox__box']").each {|i| i.click}
  end

  def check_comp_info_absent
    page.should_not have_xpath("//div[contains(@class, 'accrd-order-row__data')]")
  end

  def check_comp_info_present
    page.should have_xpath("//div[contains(@class, 'accrd-order-row__data')]")
  end

  def press_disclose_button
    var = $saved_accrd_num
    xpath = "//div[@class='accrd-order-row__data' and contains(., '#{var}')]//button[contains(., 'Раскрыть')]"
    find(:xpath, xpath).click
  end

  def check_send_button_disabled
    page.should have_xpath("//button[contains(., 'Отправить')and @disabled]")
  end

  def check_send_button_absent
    var = $saved_accrd_num
    xpath = "//div[@class='accrd-order-row__data' and contains(., '#{var}')]//button[contains(., 'Раскрыть')]"
    page.should_not have_xpath(xpath)
  end

  def refresh_accr_list
    find(:xpath, "//button[contains(., 'Обновить список')]").click
  end

  def see_accr_list_refreshed
    page.should have_xpath("//button[contains(., 'Обновить список')]")
  end

  def open_accr_archive
    find(:xpath, "//button[contains(., 'Архив')]").click
  end

  def see_accr_archive_opened
    page.should have_xpath("//button[contains(., 'Вернуться обратно')]")
  end

  def return_accr_list
    find(:xpath, "//button[contains(., 'Вернуться обратно')]").click
  end

  def see_accr_list_opened
    page.should have_xpath("//button[contains(., 'Архив')]")
  end


end