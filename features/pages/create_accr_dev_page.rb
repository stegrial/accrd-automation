require_relative '../../helpers/http_helper'
require_relative '../../features/support/utils'
require 'capybara'

include HTTPHelper
include Utils


module Create_dev

  def open_page(user)
    begin
      url = "/accr/new?token=#{HTTPHelper.get_token user}"
      puts url
      visit url
      sleep 3
    rescue
      raise 'Не удалось открыть страницу создания заявки на аккредитив'
    end
  end

  def fill_account_number(number)
    begin
      fill_in('search-seller--account-number', with: '')
      # find(:xpath, "//input[@name='search-seller--account-number']").set('')
      sleep 5
      fill_in('search-seller--account-number', with: number)
      # find(:xpath, "//input[@name='search-seller--account-number']").set(number)
      sleep 5
    rescue
      raise 'Не удалось заполнить поле - Номер счета продавца'
    end
  end

  def select_salary_account(number)
    begin
      # execute_script('window.scrollBy(0, 300)', '')
      find(:xpath, "//div[@data-reactid='83']//div//button").click
      find(:xpath, "//span[@class='menu-item__control']//*[contains(text(),'#{number}')]").click
    rescue
      raise 'Не удалось выбрать счет покупателя'
    end
  end

  def fill_amount_accr(number)
    begin
      find(:xpath, "//input[@name='about-accreditive--accreditive-amount']").set('')
      find(:xpath, "//input[@name='about-accreditive--accreditive-amount']").set(number)
    rescue
      raise 'Не удалось заполнить поле - Сумма аккредитива'
    end
  end

  def fill_address_real_estate(address)
    begin
      find(:xpath, "//textarea[@name='about-accreditive--real-estate-address']").set(address)
    rescue
      raise 'Не удалось заполнить поле - Адрес приобретаемой недвижимости'
    end
  end

  def fill_contract_number(number)
    begin
      find(:xpath, "//input[@name='about-document--contract-number']").set(number)
    rescue
      raise 'Не удалось заполнить поле - Номер договора'
    end
  end

  def fill_contract_date(date)
    begin
      find(:xpath, "//input[@data-reactid='149']").set('')
      find(:xpath, "//input[@data-reactid='149']").set(date)
    rescue
      raise 'Не удалось заполнить поле - Дата договора'
    end
  end

  def fill_contract_name(name)
    begin
      find(:xpath, "//input[@name='about-document--contract-name']").set(name)
    rescue
      raise 'Не удалось заполнить поле - Наименование договора'
    end
  end

  def upload_contract_copy
    begin
      find(:xpath, "//input[@data-reactid='175']", visible: false).set(File.join(Dir.pwd, 'config/contract_copy.pdf'))
      page.should have_xpath("//div[@data-reactid='165']//span[text()='contract_copy.pdf']")
    rescue
      raise 'Не удалось загрузить копию договора купли-продажи'
    end
  end

  def fill_conditions(conditions)
    begin
      find(:xpath, "//textarea[@name='about-document--contract-conditions']").set(conditions)
    rescue
      raise 'Не удалось заполнить поле - Условия исполнения договора'
    end
  end

  def print_statement
    begin
      # execute_script('window.scrollBy(0, 300)', '')
      page.should_not have_xpath("//button[@data-reactid='192' and @disabled]")
      find(:xpath, "//button[@data-reactid='192']").click
    rescue
      raise 'Не удалось распечатать заявление'
    end
  end

  def upload_statement
    begin
      find(:xpath, "//input[@data-reactid='204']", visible: false).set(File.join(Dir.pwd, 'config/statement.pdf'))
      page.should have_xpath("//div[@data-reactid='194']//span[text()='statement.pdf']")
    rescue
      raise 'Не удалось приложить заявление'
    end
  end

  def open_accr
    begin
      find(:xpath, "//button[@data-reactid='208' and contains(., 'Открыть')]").click

    rescue
      raise 'Не удалось открыть аккредитив'
    end
  end

  def check_accr
    begin
      # execute_script('window.scrollBy(0, 300)', '')
      find(:xpath, "//button[@data-reactid='208' and contains(., 'Проверить незаполненные поля')]").click
    rescue
      raise 'Не удалось выполнить проверку незаполненных полей'
    end
  end

  def check_disabled_buttons(list_buttons)
    begin
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
    begin
      find(:xpath, "//input[@data-reactid='149']").click
    rescue
      raise 'Не удалось кликнуть по полю - Дата договора'
    end
  end

  def date_compare_calendar(month, year)
    begin
      month_ru = {'01' => 'Январь', '02' => 'Февраль', '03' => 'Март',
                  '04' => 'Апрель', '05' => 'Май', '06' => 'Июнь',
                  '07' => 'Июль','08' => 'Август','09' => 'Сентябрь',
                  '10' => 'Октябрь','11' => 'Ноябрь','12' => 'Декабрь'}

      current_month = "#{month_ru[month]} #{year}"
      find(:xpath, "//div[@class='calendar__name']").text.should == current_month
    rescue
      raise 'Календарь не отображается или не соответствует текущему месяцу'
    end
  end

  def calendar_double_arrow_back
    begin
      find(:xpath, "//div[@class='calendar__arrow calendar__arrow_direction_left calendar__arrow_double']").click
    rescue
      raise 'Не удалось в календаре нажать на двойную стрелку - назад'
    end
  end

  def calendar_double_arrow_forward
    begin
      find(:xpath, "//div[@class='calendar__arrow calendar__arrow_direction_right calendar__arrow_double']").click
    rescue
      raise 'Не удалось в календаре нажать на двойную стрелку - вперед'
    end
  end

  def calendar_single_arrow_back
    begin
      find(:xpath, "//div[@class='calendar__arrow calendar__arrow_direction_left']").click
    rescue
      raise 'Не удалось в календаре нажать на одинарную стрелку - назад'
    end
  end

  def calendar_single_arrow_forward
    begin
      find(:xpath, "//div[@class='calendar__arrow calendar__arrow_direction_right']").click
    rescue
      raise 'Не удалось в календаре нажать на одинарную стрелку - вперед'
    end
  end

  def select_current_date(day)
    begin
     find(:xpath, "//table[@class='calendar__layout']//td[@data-day='#{day}']").click
    rescue
      raise 'Не удалось в календаре выбрать текущую дату'
    end
  end

  def remove_contract_copy
    begin
      find(:xpath, "//div[@data-reactid='165']//button[@class='attach__clear']").click
    rescue
      raise 'Не удалось удалить прикрепленный файл копии договора купли-продажи'
    end
  end

  def fill_bic_number(number)
    begin
      find(:xpath, "//input[@name='search-seller--bank-bik']").set('')
      find(:xpath, "//input[@name='search-seller--bank-bik']").set(number)
      sleep 3
    rescue
      raise 'Не удалось заполнить поле - БИК банка продавца'
    end
  end

  def fill_inn_number_dev(number)
    begin
      find(:xpath, "//input[@name='search-seller--developer--inn']").set('')
      find(:xpath, "//input[@name='search-seller--developer--inn']").set(number)
    rescue
      raise 'Не удалось заполнить поле - ИНН продавца юр.лица'
    end
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
    begin
      find(:xpath, "//input[@name='search-seller--developer--ogrn']").set('')
      find(:xpath, "//input[@name='search-seller--developer--ogrn']").set(number)
    rescue
      raise 'Не удалось заполнить поле - ОГРН организации продавца'
    end
  end

  def fill_address_seller_org(address_org)
    begin
      find(:xpath, "//input[@name='search-seller--developer--address']").set(address_org)
    rescue
      raise 'Не удалось заполнить поле - Адрес организации продавца'
    end
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
    begin
      find(:xpath, "//div[@data-reactid='48']").click
      find(:xpath, "//span[@class='menu-item__control' and text()='#{method}']").click
    rescue
      raise 'Не удалось выбрать способ покупки'
    end
  end

  def remove_statement
    begin
      find(:xpath, "//div[@data-reactid='194']//button[@class='attach__clear']").click
    rescue
      raise 'Не удалось удалить прикрепленный файл заявления'
    end
  end

  def press_new_purchase_button
    begin
      find(:xpath, "//button[contains(@class, 'button_view_extra')and contains(., 'Новая покупка')]").click
    rescue
      raise 'Не удалось нажать на кнопку - Новая покупка'
    end
  end

  def remember_accr_lifetime
    begin
      @current_days = find(:xpath, "//input[@name='about-accreditive--liftime-in-days']").value.to_i
    rescue
      raise 'Не удалось запомнить установленный срок действия аккредитива'
    end
  end

  def remove_field_value(field)
    begin
      find(:xpath, field).set('').set(' ').double_click.send_keys :backspace
    rescue
      raise 'Не удалось удалить значение поля'
    end
  end

  def fill_accr_lifetime(days)
    begin
      days = @current_days + 1 if days == 'max'
      fill_in('about-accreditive--liftime-in-days', with: '')
      fill_in('about-accreditive--liftime-in-days', with: days)
    rescue
      raise 'Не удалось заполнить поле - Срок действия аккредитива'
    end
  end

  def see_message_accr_lifetime
    begin
      text = "Срок действия аккредитива должен быть больше 0, но меньше или равен #{@current_days} дней"
      page.should have_text(text)
    rescue
      raise 'Сообщение не отображается'
    end
  end

  def check_accr_lifetime
    begin
      xpath = "//span[contains(@class,'input_focused')]//input[@name='about-accreditive--liftime-in-days']"
      page.should have_xpath(xpath)
    rescue
      raise 'Поле Срок действия аккредитива не определено как поле заполненное неверно'
    end
  end

  def fill_second_buyer_name(full_name)
    begin
      fill_in('about-document--contract-second-buyer', with: full_name)
    rescue
      raise 'Не удалось заполнить поле - ФИО второго покупателя'
    end
  end

  def delete_last_digit(field)
    begin
      find(:xpath, field).send_keys :backspace
    rescue
      raise 'Не удалось удалить последнюю цифру'
    end
  end

  def check_total_payment(count)
    begin
      page.should have_text(count)
    rescue
      raise 'Отображается неверная сумма - Всего к оплате'
    end
  end

  def check_commission(count)
    begin
     page.should have_text(count)
    rescue
      raise 'Отображается неверная сумма комиссии'
    end
  end

  def check_scanned_statement
    begin
     page.should have_xpath("//span[@data-reactid='200' and contains(@class,'is-required')]")
    rescue
      raise 'Подписанный скан заявления не определен как обязательный документ'
    end
  end

end