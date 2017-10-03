# encoding: UTF-8

require_relative '../../helpers/http_helper'
require_relative '../../features/support/utils'
require 'capybara'

include HTTPHelper
include Utils

module Create_dev
  def open_page(user)
    begin
      url = "/accr/new?ad-token=#{HTTPHelper.get_token user}"
      puts url
      visit url
      sleep 3
    rescue
      raise 'Не удалось открыть страницу создания заявки на аккредитив'
    end
  end

  def fill_account_number(number)
    fill_in('search-seller--account-number', with: '')
    # find(:xpath, "//input[@name='search-seller--account-number']").set('')
    fill_in('search-seller--account-number', with: number)
    # find(:xpath, "//input[@name='search-seller--account-number']").set(number)
    sleep 5
  rescue
    raise 'Не удалось заполнить поле - Номер счета продавца'
  end

  def select_salary_account(number)
    # execute_script('window.scrollBy(0, 300)', '')
    find(:xpath, "//div[@data-reactid='83']//div//button").click
    find(:xpath, "//span[@class='menu-item__control']//*[contains(text(),'#{number}')]").click
  rescue
    raise 'Не удалось выбрать счет покупателя'
  end

  def fill_amount_accr(number)
    find(:xpath, "//input[@name='about-accreditive--accreditive-amount']").set('')
    find(:xpath, "//input[@name='about-accreditive--accreditive-amount']").set(number)
  rescue
    raise 'Не удалось заполнить поле - Сумма аккредитива'
  end

  def fill_address_real_estate(address)
    find(:xpath, "//textarea[@name='about-accreditive--real-estate-address']").set(address)
  rescue
    raise 'Не удалось заполнить поле - Адрес приобретаемой недвижимости'
  end

  def fill_contract_number(number)
    find(:xpath, "//input[@name='about-document--contract-number']").set(number)
  rescue
    raise 'Не удалось заполнить поле - Номер договора'
  end

  def fill_contract_date(date)
    find(:xpath, "//input[@data-reactid='149']").set('')
    find(:xpath, "//input[@data-reactid='149']").set(date)
  rescue
    raise 'Не удалось заполнить поле - Дата договора'
  end

  def fill_contract_name(name)
    find(:xpath, "//input[@name='about-document--contract-name']").set(name)
  rescue
    raise 'Не удалось заполнить поле - Наименование договора'
  end

  def upload_contract_copy
    find(:xpath, "//input[@data-reactid='175']", visible: false).set(File.join(Dir.pwd, 'config/contract_copy.pdf'))
    page.should have_xpath("//div[@data-reactid='165']//span[text()='contract_copy.pdf']")
  rescue
    raise 'Не удалось загрузить копию договора купли-продажи'
  end

  def fill_conditions(conditions)
    find(:xpath, "//textarea[@name='about-document--contract-conditions']").set(conditions)
  rescue
    raise 'Не удалось заполнить поле - Условия исполнения договора'
  end

  def print_statement
    # execute_script('window.scrollBy(0, 300)', '')
    page.should_not have_xpath("//button[@data-reactid='192' and @disabled]")
    find(:xpath, "//button[@data-reactid='192']").click
  rescue
    raise 'Не удалось распечатать заявление'
  end

  def upload_statement
    find(:xpath, "//input[@data-reactid='204']", visible: false).set(File.join(Dir.pwd, 'config/statement.pdf'))
    page.should have_xpath("//div[@data-reactid='194']//span[text()='statement.pdf']")
  rescue
    raise 'Не удалось приложить заявление'
  end

  def open_accr
    find(:xpath, "//button[@data-reactid='208' and contains(., 'Открыть')]").click
  rescue
    raise 'Не удалось открыть аккредитив'
  end

  def check_accr
    # execute_script('window.scrollBy(0, 300)', '')
    find(:xpath, "//button[@data-reactid='208' and contains(., 'Проверить незаполненные поля')]").click
  rescue
    raise 'Не удалось выполнить проверку незаполненных полей'
  end

  def check_disabled_buttons(list_buttons)
    xpath = ''
    butt = list_buttons.split(/,/)
    butt.each do |button_name|
      case button_name
      when 'Распечатать'
        xpath = "//div[@data-reactid='191']//button[@disabled]"
      when 'Приложить'
        xpath = "//span[@data-reactid='201' and @disabled]"
      else
        puts 'Error'
      end
      p xpath
      page.should have_xpath(xpath)
    end
  rescue
    raise "Кнопки #{list_buttons} оказались доступны"
  end

  def get_field_path(field)
    xpath = ''
    case field
    when 'Сумма аккредитива'
      xpath = "//input[@name='about-accreditive--accreditive-amount']"
    when 'Адрес приобретаемой недвижимости'
      xpath = "//textarea[@name='about-accreditive--real-estate-address']"
    when 'Номер договора'
      xpath = "//input[@name='about-document--contract-number']"
    when 'Дата договора'
      xpath = "//input[@data-reactid='149']"
    when 'Наименование договора'
      xpath = "//input[@name='about-document--contract-name']"
    when 'Условия исполнения договора'
      xpath = "//textarea[@name='about-document--contract-conditions']"
    when 'Номер счета продавца'
      xpath = "//input[@name='search-seller--account-number']"
    when 'ИНН продавца юр.лица'
      xpath = "//input[@name='search-seller--developer--inn']"
    when 'ИНН продавца физ.лица'
      xpath = "//input[@name='search-seller--individual--inn']"
    when 'Наименование организации продавца'
      xpath = "//input[@name='search-seller--developer--name']"
    when 'ОГРН организации продавца'
      xpath = "//input[@name='search-seller--developer--ogrn']"
    when 'БИК банка продавца'
      xpath = "//input[@name='search-seller--bank-bik']"
    when 'Адрес организации продавца'
      xpath = "//input[@name='search-seller--developer--address']"
    when 'Серия паспорта'
      xpath = "//input[@name='search-seller--individual--passport-series']"
    when 'Номер паспорта'
      xpath = "//input[@name='search-seller--individual--passport-number']"
    when 'Когда выдан паспорт'
      xpath = "//input[@tabindex='46']"
    when 'Дата рождения'
      xpath = "//input[@tabindex='47']"
    when 'Срок действия аккредитива'
      xpath = "//input[@name='about-accreditive--liftime-in-days']"
    when 'ФИО продавца'
      xpath = "//input[@name='search-seller--individual--fullName']"
    when 'Кем выдан паспорт'
      xpath = "//input[@name='search-seller--individual--passport-issued-by']"
    when 'Место рождения'
      xpath = "//input[@name='search-seller--individual--birth-place']"
    when 'Гражданство'
      xpath = "//input[@name='search-seller--individual--citizenship']"
    when 'Адрес регистрации'
      xpath = "//input[@name='search-seller--individual--address']"
    else
      puts 'Error'
    end
    p xpath
  end

  def click_contract_date
    find(:xpath, "//input[@data-reactid='149']").click
  rescue
    raise 'Не удалось кликнуть по полю - Дата договора'
  end

  def date_compare_calendar(month, year)
    month_ru = { '01' => 'Январь', '02' => 'Февраль', '03' => 'Март',
                 '04' => 'Апрель', '05' => 'Май', '06' => 'Июнь',
                 '07' => 'Июль', '08' => 'Август', '09' => 'Сентябрь',
                 '10' => 'Октябрь', '11' => 'Ноябрь', '12' => 'Декабрь' }

    current_month = "#{month_ru[month]} #{year}"
    find(:xpath, "//div[@class='calendar__name']").text.should == current_month
  rescue
    raise 'Календарь не отображается или не соответствует текущему месяцу'
  end

  def calendar_double_arrow_back
    find(:xpath, "//div[@class='calendar__arrow calendar__arrow_direction_left calendar__arrow_double']").click
  rescue
    raise 'Не удалось в календаре нажать на двойную стрелку - назад'
  end

  def calendar_double_arrow_forward
    find(:xpath, "//div[@class='calendar__arrow calendar__arrow_direction_right calendar__arrow_double']").click
  rescue
    raise 'Не удалось в календаре нажать на двойную стрелку - вперед'
  end

  def calendar_single_arrow_back
    find(:xpath, "//div[@class='calendar__arrow calendar__arrow_direction_left']").click
  rescue
    raise 'Не удалось в календаре нажать на одинарную стрелку - назад'
  end

  def calendar_single_arrow_forward
    find(:xpath, "//div[@class='calendar__arrow calendar__arrow_direction_right']").click
  rescue
    raise 'Не удалось в календаре нажать на одинарную стрелку - вперед'
  end

  def select_current_date(day)
    find(:xpath, "//table[@class='calendar__layout']//td[@data-day='#{day}']").click
  rescue
    raise 'Не удалось в календаре выбрать текущую дату'
  end

  def remove_contract_copy
    find(:xpath, "//div[@data-reactid='165']//button[@class='attach__clear']").click
  rescue
    raise 'Не удалось удалить прикрепленный файл копии договора купли-продажи'
  end

  def fill_bic_number(number)
    find(:xpath, "//input[@name='search-seller--bank-bik']").set('')
    find(:xpath, "//input[@name='search-seller--bank-bik']").set(number)
    sleep 3
  rescue
    raise 'Не удалось заполнить поле - БИК банка продавца'
  end

  def fill_inn_number_dev(number)
    find(:xpath, "//input[@name='search-seller--developer--inn']").set('')
    find(:xpath, "//input[@name='search-seller--developer--inn']").set(number)
  rescue
    raise 'Не удалось заполнить поле - ИНН продавца юр.лица'
  end

  def get_disabled_field_path(field)
    xpath = ''
    case field
    when 'Наименование организации продавца'
      xpath = "//input[@name='search-seller--developer--name' and @disabled]"
    when 'ОГРН организации продавца'
      xpath = "//input[@name='search-seller--developer--ogrn' and @disabled]"
    when 'Адрес организации продавца'
      xpath = "//input[@name='search-seller--developer--address' and @disabled]"
    when 'Название банка продавца'
      xpath = "//input[@name='search-seller--bank-name' and @disabled]"
    when 'Корреспондентский счет банка продавца'
      xpath = "//input[@name='search-seller--bank-cor-account' and @disabled]"
    else
      puts 'Error'
    end
    p xpath
  end

  def fill_ogrn_number(number)
    find(:xpath, "//input[@name='search-seller--developer--ogrn']").set('')
    find(:xpath, "//input[@name='search-seller--developer--ogrn']").set(number)
  rescue
    raise 'Не удалось заполнить поле - ОГРН организации продавца'
  end

  def fill_address_seller_org(address_org)
    find(:xpath, "//input[@name='search-seller--developer--address']").set(address_org)
  rescue
    raise 'Не удалось заполнить поле - Адрес организации продавца'
  end

  def fill_name_seller_org(name_org)
    find(:xpath, "//input[@name='search-seller--developer--name']").set(name_org)
    # begin
    #   find(:xpath, "//input[@name='search-seller--developer--name']").set(name_org)
    # rescue
    #   raise 'Не удалось заполнить поле - Наименование организации продавца'
    # end
  end

  def select_purchase_method(method)
    find(:xpath, "//div[@data-reactid='48']").click
    find(:xpath, "//span[@class='menu-item__control' and text()='#{method}']").click
  rescue
    raise 'Не удалось выбрать способ покупки'
  end

  def remove_statement
    find(:xpath, "//div[@data-reactid='194']//button[@class='attach__clear']").click
  rescue
    raise 'Не удалось удалить прикрепленный файл заявления'
  end

  def press_new_purchase_button
    find(:xpath, "//button[contains(@class, 'button_view_extra')and contains(., 'Новая покупка')]").click
  rescue
    raise 'Не удалось нажать на кнопку - Новая покупка'
  end

  def remember_accr_lifetime
    @current_days = find(:xpath, "//input[@name='about-accreditive--liftime-in-days']").value.to_i
  rescue
    raise 'Не удалось запомнить установленный срок действия аккредитива'
  end

  def remove_field_value(field)
    find(:xpath, field).set('').set(' ').double_click.send_keys :backspace
  rescue
    raise 'Не удалось удалить значение поля'
  end

  def fill_accr_lifetime(days)
    days = @current_days + 1 if days == 'max'
    fill_in('about-accreditive--liftime-in-days', with: '')
    fill_in('about-accreditive--liftime-in-days', with: days)
  rescue
    raise 'Не удалось заполнить поле - Срок действия аккредитива'
  end

  def see_message_accr_lifetime
    text = "Срок действия аккредитива должен быть больше 0, но меньше или равен #{@current_days} дней"
    page.should have_text(text)
  rescue
    raise 'Сообщение не отображается'
  end

  def check_accr_lifetime
    xpath = "//span[contains(@class,'input_focused')]//input[@name='about-accreditive--liftime-in-days']"
    page.should have_xpath(xpath)
  rescue
    raise 'Поле Срок действия аккредитива не определено как поле заполненное неверно'
  end

  def fill_second_buyer_name(full_name)
    fill_in('about-document--contract-second-buyer', with: full_name)
  rescue
    raise 'Не удалось заполнить поле - ФИО второго покупателя'
  end

  def delete_last_digit(field)
    find(:xpath, field).send_keys :backspace
  rescue
    raise 'Не удалось удалить последнюю цифру'
  end

  def check_total_payment(count)
    page.should have_text(count)
  rescue
    raise 'Отображается неверная сумма - Всего к оплате'
  end

  def check_commission(count)
    page.should have_text(count)
  rescue
    raise 'Отображается неверная сумма комиссии'
  end

  def check_scanned_statement
    page.should have_xpath("//span[@data-reactid='200' and contains(@class,'is-required')]")
  rescue
    raise 'Подписанный скан заявления не определен как обязательный документ'
  end
end
