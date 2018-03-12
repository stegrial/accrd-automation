# encoding: UTF-8

require_relative '../../helpers/http_helper'
require_relative '../../features/support/utils'
require 'capybara/rspec'
require 'mongo'
require 'json'


include HTTPHelper
include Utils


module SearchNumber

  def open_search_number_page(user)
    begin
      url = "/accrd-ui/accr/search?ad-token=#{HTTPHelper.get_token user}"
      # puts url
      visit url
    rescue
      raise 'Не удалось открыть страницу с формой поиска заявки по номеру'
    end
  end

  def press_find_button
    element_path = "//button[contains(., 'Найти') and not(@disabled)]//span"
    find(:xpath, element_path).click
  rescue
    raise 'Не удалось нажать на кнопку - Найти'
  end

  def enter_search_value(search_value)
    element_path = "//input[@class='input__control']"
    find(:xpath, element_path).set('')
    find(:xpath, element_path).set(search_value)
  rescue
    raise 'Не удалось ввести значение для поиска'
  end

  def remember_new_number
    begin
      $saved_accrd_num = find(:xpath, "//span[@class='label__inner' and contains(., 'ACCD')]").text
    rescue
      raise 'Не удалось запомнить номер заявки на аккредитив'
    end
  end

  def some(accr_id)
    client = Mongo::Client.new(['172.28.59.23:27021'], database: 'accrd')

    database = client.database

    p database.collections #=> Returns an array of Collection objects.
    p database.collection_names #=> Returns an array of collection names as strings.


    # Get coveringAccount from DB
    collection_orders = client[:accreditiveOrders]
    accreditive = collection_orders.find({number: accr_id}).first
    covering_account = accreditive['accreditive']['coveringAccount']


    # Get time from DB
    collection_settings = client[:settings].find('_id' => 'eq_unit_date').first
    actual_server_date = collection_settings['value']
    p actual_server_date

    date = DateTime.parse(actual_server_date.to_s)
    date.iso8601
    puts date

    HTTPHelper.get_acc_statement date, covering_account
  end

  def enter_no_exist_number
    begin
      no_exist_number = "#{$saved_accrd_num[0...-1]}#{$saved_accrd_num[-1].to_i+1}"
      enter_search_value no_exist_number
    rescue
      raise 'Не удалось ввести несуществующий номер заявки'
    end
  end

  def save_contract_copy
    begin
      find(:xpath, "//span[@class='button__text' and text()='contract_copy.pdf']").click
    rescue
      raise 'Не удалось сохранить копию договора купли-продажи'
    end
  end

  def save_statement
    begin
      find(:xpath, "//span[@class='button__text' and text()='statement.pdf']").click
    rescue
      raise 'Не удалось сохранить копию заявления'
    end
  end

  def press_edit_button
    begin
      find(:xpath, "//span[contains(@class, 'button__text') and contains(., 'Редактировать')]").click
    rescue
      raise 'Не удалось нажать на кнопку - Редактировать'
    end
  end

  def confirm_entered_data
    begin
      find(:xpath, "//button[contains(@class, 'new-accreditive__submit-button') and contains(., 'Открыть')]").click
    rescue
      raise 'Не удалось подтвердить введенные данные в заявке'
    end
  end

  def confirm_statement
    begin
      javascript_scroll 2000
      find(:xpath, "//span[contains(@class, 'button__text') and contains(., 'Подтвердить')]").click

    rescue
      raise 'Не удалось подтвердить заявку на аккредитив'
    end
  end

  def redirect_by_link(link_name)
    click_link(link_name)
  end

  def check_dev_list_page_opened
    expect(page).to have_current_path(Capybara.app_host + 'accrd-ui/approved-developers#', url: true)
    expect(page).to have_text('Аккредитованные застройщики')
  end

  def enter_dev_name(dev_name)
    fill_in('approved-developers--name-filter', with: dev_name)
  end

  def check_dev_name_displayed_only(dev_name)
    self.check_dev_name_displayed(dev_name)
    expect(all(:xpath, "//div[@class='fullName']").count).to eq 2
  end

  def check_dev_name_displayed(dev_name)
    expect(page).to have_xpath("//div[@class='fullName' and text()='#{dev_name}']")
  end

  def check_none_dev_displayed
    expect(all(:xpath, "//div[@class='fullName']").count).to eq 1
  end

  def enter_inn_number_dev(number)
    length = page.evaluate_script(%q(document.querySelector("input[name='approved-developers--name-filter']").value.length;))
    length.to_i.times do
      page.find_field('approved-developers--name-filter').send_keys :backspace
    end
    fill_in('approved-developers--inn-filter', with: number)
  end

  def check_accr_number_page_opened
    expect(page).to have_current_path(Capybara.app_host + 'accrd-ui/accr/search#', url: true)
    expect(page).to have_text('Номер заявки или часть ФИО клиента')
  end

  # def remember_account_balance проверка что деньги сняты со счета
  #   $account_balance = find(:xpath, "").text
  # end

end