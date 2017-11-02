# encoding: UTF-8

require_relative '../../helpers/http_helper'
require_relative '../../features/support/utils'
require 'capybara'

include HTTPHelper
include Utils

# This module for search accrd
module SearchPage

  def open_search_page(user)
    url = "/accrd-ui/disclose/search?ad-token=#{HTTPHelper.get_token user}"
    visit url
  rescue
    raise 'Не удалось открыть страницу с формой поиска заявки по ФИО'
  end

  def press_attach_documents_button
    begin
      first(:xpath, "//button[contains(., 'Приложить документы')]").click
    rescue
      raise 'Не удалось нажать на кнопку - Приложить документы'
    end
  end

  def open_attach_documents_page(user)
    begin
      url = "/accrd-ui/disclose/pack/#{$saved_accrd_num}?token=#{HTTPHelper.get_token user}"
      puts url
      visit url
    rescue
      raise 'Не удалось открыть страницу для раскрытия заявки'
    end
  end

  def upload_disclosure_document(number)
    input = "//input[@class='attach__control']"
    case number
      when 'первый'
        find(:xpath, input, visible: false).set(File.join(Dir.pwd, 'config/disclosure_document_1.pdf'))
      when 'второй'
        find(:xpath, input, visible: false).set(File.join(Dir.pwd, 'config/disclosure_document_2.pdf'))
      when 'третий'
        find(:xpath, input, visible: false).set(File.join(Dir.pwd, 'config/disclosure_document_3.pdf'))
      else
        puts 'Error'
    end
  rescue
    raise 'Не удалось приложить первый или второй или третий документ'
  end

  def remove_disclosure_document
    find(:xpath, "//button[@class='attach__clear']").click
  rescue
    raise 'Не удалось удалить прикрепленный файл документа раскрытия'
  end

  def press_create_button
    page.should_not have_xpath("//button[contains(., 'Создать')and @disabled]")
    find(:xpath, "//button[contains(., 'Создать')]").click
  rescue
    raise 'Не удалось нажать на кнопку - Создать'
  end

  def get_disclosure_document_path(doc_number)
    xpath = ''
    case doc_number
      when 'первый'
        xpath = "//span[@class='button__text' and text()='disclosure_document_1.pdf']"
      when 'второй'
        xpath = "//span[@class='button__text' and text()='disclosure_document_2.pdf']"
      when 'третий'
        xpath = "//span[@class='button__text' and text()='disclosure_document_3.pdf']"
      else
        puts 'Error'
    end
    p xpath
  end

  def date_compare_disclosure_doc(year, month, day)
    begin
      current_date = "#{day}.#{month}.#{year}"
      page.should have_xpath("//span[@class='label__inner' and text()='#{current_date}']")
    rescue
      raise 'Не удалось сравнить дату загрузки документа или дата загрузки документа не соответствует текущей'
    end
  end

  def enter_email_address(email_address)
    begin
      find(:xpath, "//input[@class='input__control']").set('')
      find(:xpath, "//input[@class='input__control']").set(email_address)
    rescue
      raise 'Не удалось указать Email'
    end
  end

  def save_disclosure_document
    begin
      find(:xpath, "//span[@class='button__text' and text()='disclosure_document_1.pdf']").click
    rescue
      raise 'Не удалось сохранить документ раскрытия'
    end
  end

  def press_return_back_button
    begin
      find(:xpath, "//button[contains(., 'Вернуться обратно')]").click
    rescue
      raise 'Не удалось нажать на кнопку - Вернуться обратно'
    end
  end

end