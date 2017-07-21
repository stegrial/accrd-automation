require_relative '../../helpers/http_helper'
require_relative '../../features/support/utils'
require 'capybara'


include HTTPHelper
include Utils

module Search_full_name

  def open_search_full_name_page(user)
    url = "/disclose/search?token=#{HTTPHelper.get_token user}"
    puts url
    visit url
  end

  def press_attach_documents_button
    first(:xpath, "//button[contains(., 'Приложить документы')]").click
  end

  def open_attach_documents_page(user)
    url = "/disclose/pack/#{$new_generated_accr_number}?token=#{HTTPHelper.get_token user}"
    puts url
    visit url
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
  end

  def remove_disclosure_document
    find(:xpath, "//button[@class='attach__clear']").click
  end

  def press_create_button
    sleep 2
    find(:xpath, "//button[contains(., 'Создать')]").click
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
    current_date = "#{year}-#{month}-#{day}"
    page.should have_xpath("//span[@class='label__inner' and text()='#{current_date}']")
  end

  def enter_email_address(email_address)
    find(:xpath, "//input[@class='input__control']").set('')
    find(:xpath, "//input[@class='input__control']").set(email_address)
  end

  def save_disclosure_document
    find(:xpath, "//span[@class='button__text' and text()='disclosure_document_1.pdf']").click
  end

  def press_return_back_button
    find(:xpath, "//button[contains(., 'Вернуться обратно')]").click
  end

end