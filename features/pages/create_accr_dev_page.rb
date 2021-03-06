# encoding: UTF-8

require_relative '../../helpers/http_helper'
require_relative '../../features/support/utils'
require 'capybara/cucumber'

include HTTPHelper
include Utils


module Create_dev

  @@open_accrd = "//span[text()='Открыть']"
  @@check_empty_field = "//span[text()='Проверить незаполненные поля']"
  @@open_accrd_button = "//button[contains(@class, 'new-accreditive__submit-button')]"
  @@statement_file = "//div[contains(@class, 'form-field') and contains(., 'statement.pdf')]"

  def open_page(user)
        url = "/accrd-ui/accr/new?ad-token=#{HTTPHelper.get_token user}"
        visit url
        sleep 3
  rescue
    raise 'Не удалось открыть страницу создания заявки на аккредитив'
  end

  def new_accrd_page?
    page.should have_xpath(@@open_accrd_button)
    page.should have_text('Покупка недвижимости через Аккредитив')
  end

  def select_purchase_method(method)
    find(:xpath, "//div[@name='about-accreditive--sell-type']").click
    find(:xpath, "//span[@class='menu-item__control' and text()='#{method}']").click
  rescue
    raise 'Не удалось выбрать способ покупки'
  end

  def fill_account_number(number)
    fill_in('search-seller--account-number', with: '')
    fill_in('search-seller--account-number', with: number)

    value = find(:xpath, "//input[@name='search-seller--account-number']").value

    if value.size != number.to_s.size
      fill_in('search-seller--account-number', with: number)
    end

    sleep 5
  rescue
    raise 'Не удалось заполнить поле - Номер счета продавца'
  end

  def fill_accr_lifetime(days)
    days = @current_days + 1 if days == 'max'
    fill_in('about-accreditive--liftime-in-days', with: '')
    fill_in('about-accreditive--liftime-in-days', with: days)
  rescue
    raise 'Не удалось заполнить поле - Срок действия аккредитива'
  end

  def remember_accr_lifetime
    @current_days = find(:xpath, "//input[@name='about-accreditive--liftime-in-days']").value.to_i
  rescue
    raise 'Не удалось запомнить установленный срок действия аккредитива'
  end

  def select_salary_account(number)
    sleep 1
    find(:xpath, "//div[@name='about-accreditive--client-account-number']").click
    find(:xpath, "//span[@class='menu-item__control']//span[text()='#{number}']").click
  rescue
    raise 'Не удалось выбрать счет покупателя'
  end

  def fill_amount_accr(amount)
    find(:xpath, "//input[@name='about-accreditive--accreditive-amount']").set('')
    find(:xpath, "//input[@name='about-accreditive--accreditive-amount']").set(amount)
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
    find(:xpath, "//input[@name='about-document--contract-date']").set('')
    find(:xpath, "//input[@name='about-document--contract-date']").set(date)
  rescue
    raise 'Не удалось заполнить поле - Дата договора'
  end

  def fill_contract_name(name)
    find(:xpath, "//input[@name='about-document--contract-name']").set(name)
  rescue
    raise 'Не удалось заполнить поле - Наименование договора'
  end

  def upload_contract_copy
    file_path = File.join(Dir.pwd, 'config/contract_copy.pdf')
    file = File.basename file_path
    find(:xpath, "//input[@name='about-document--contract-attachments']", visible: false).set(file_path)

    # Check attachment after attach action
    page.should have_xpath("//span[@class='attach__text' and text()='#{file}']")
  rescue
    raise 'Не удалось загрузить копию договора купли-продажи'
  end

  def fill_conditions(conditions)
    find(:xpath, "//textarea[@name='about-document--contract-conditions']").set(conditions)
  rescue
    raise 'Не удалось заполнить поле - Условия исполнения договора'
  end

  def print_statement
    element_name = 'new-accreditive--print'
    expect(page).not_to have_xpath("//button[@name='#{element_name}' and @disabled]")
    find(:xpath, "//button[@name='#{element_name}']").click
  rescue
    raise 'Не удалось распечатать заявление'
  end

  def upload_statement
    find(:xpath, "//span[contains(@class, 'attach__button') and contains(., 'Приложить')]//input", visible: false).set(File.join(Dir.pwd, 'config/statement.pdf'))
    page.should have_xpath(@@statement_file)
  rescue
    raise 'Не удалось приложить заявление'
  end

  def open_accr
    find(:xpath, "#{@@open_accrd_button}#{@@open_accrd}").click
  rescue
    raise 'Не удалось открыть аккредитив'
  end

  def check_accr
    find(:xpath, "#{@@open_accrd_button}#{@@check_empty_field}").click
  rescue
    raise 'Не удалось выполнить проверку незаполненных полей'
  end

  def check_disabled_buttons(list_buttons)
    butt = list_buttons.split(/,/)
    butt.each do |button_name|
      xpath = case button_name
                when 'Распечатать' then
                  "//button[@name='new-accreditive--print'][@disabled]"
                when 'Приложить' then
                  "//input[@name='new-accreditive--attachments'][@disabled]"
                else
                  puts 'Button dose not present;'
              end
      page.should have_xpath(xpath, visible: false)
    end
  rescue
    raise "Кнопки #{list_buttons} оказались доступны"
  end

  def get_element_xpath(element_name)
    path = '../../../helpers/data_sets/element_selectors.yml'
    data = YAML.load_file(File.expand_path(File.dirname(__FILE__)+path))[element_name]
    xpath = ''
    xpath = data['xpath'] if data['xpath']
    p xpath
  end

  def get_element_locator(element_name)
    path = '../../../helpers/data_sets/element_selectors.yml'
    data = YAML.load_file(File.expand_path(File.dirname(__FILE__)+path))[element_name]
    locator = ''
    locator = data['locator'] if data['locator']
    p locator
  end

  def click_contract_date
    path = get_element_xpath 'Дата договора'
    find(:xpath, path).click
  rescue
    raise 'Не удалось кликнуть по полю - Дата договора'
  end

  def date_compare_calendar(month, year)
    month_ru = {'01' => 'Январь', '02' => 'Февраль', '03' => 'Март',
                '04' => 'Апрель', '05' => 'Май', '06' => 'Июнь',
                '07' => 'Июль', '08' => 'Август', '09' => 'Сентябрь',
                '10' => 'Октябрь', '11' => 'Ноябрь', '12' => 'Декабрь'}

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
    all(:xpath, "//div[contains(@class, 'contract-attach')]//button[@class='attach__clear']")[0].click
  rescue
    raise 'Не удалось удалить прикрепленный файл копии договора купли-продажи'
  end

  def fill_bic_number(number)
    javascript_scroll 400
    find(:xpath, "//input[@name='search-seller--bank-bik']").set('')
    find(:xpath, "//input[@name='search-seller--bank-bik']").set(number)
    # wait_for_ajax
    sleep 3
    # expect(find(:xpath, get_disabled_field_path('Название банка продавца'))).to have_selector("input[value='']")
    # puts find(:xpath, get_disabled_field_path('Название банка продавца')).value
  rescue
    raise 'Не удалось заполнить поле - БИК банка продавца'
  end

  def fill_inn_number_dev(number)
    find(:xpath, "//input[@name='search-seller--developer--inn']").set('')
    find(:xpath, "//input[@name='search-seller--developer--inn']").set(number)
  rescue
    raise 'Не удалось заполнить поле - ИНН продавца юр.лица'
  end

  def fill_kpp_number(number)
    find(:xpath, "//input[@name='search-seller--developer--kpp']").set('')
    find(:xpath, "//input[@name='search-seller--developer--kpp']").set(number)
  rescue
    raise 'Не удалось заполнить поле - КПП продавца'
  end

  def fill_cor_account(number)
    find(:xpath, "//input[@name='search-seller--bank-cor-account']").set('')
    find(:xpath, "//input[@name='search-seller--bank-cor-account']").set(number)
  rescue
    raise 'Не удалось заполнить поле - Корреспондентский счет продавца'
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

  def fill_bank_name(name)
    find(:xpath, "//textarea[@name='search-seller--bank-name']").set('')
    find(:xpath, "//textarea[@name='search-seller--bank-name']").set(name)
  rescue
    raise 'Не удалось заполнить поле - Название банка'
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
    begin
      javascript_scroll 300
      find(:xpath, "//input[@name='search-seller--developer--name']").set(name_org)
    rescue
      raise 'Не удалось заполнить поле - Наименование организации продавца'
    end
  end


  def remove_statement
    find(:xpath, "//div[contains(@class, 'form-field') and contains(., 'Приложить')]//button[@class='attach__clear']").click
  rescue
    raise 'Не удалось удалить прикрепленный файл заявления'
  end

  def remove_all_statements
    page.should have_xpath(@@statement_file)
    clear = "//div[contains(@class, 'form-field') and contains(., 'Приложить')]//button[@class='attach__clear']"
    all(:xpath, clear).each {|statement| statement.click}
  rescue
    raise 'Не удалось удалить прикрепленные файлы заявления'
  end

  def check_statement_document_list
    sleep 2
    page.should_not have_xpath(@@statement_file)
  rescue
    raise 'Заявление присуцтвует в списке прикрепленых документов'
  end


  def press_new_purchase_button
    find(:xpath, "//button[contains(@class, 'button_view_extra')and contains(., 'Новая покупка')]").click
  rescue
    raise 'Не удалось нажать на кнопку - Новая покупка'
  end


  def remove_field_value(field)
    page.find_field(field).set('')
    page.find_field(field).set('').set(' ').double_click.send_keys :backspace
    # find(:xpath, field).set('')
    # find(:xpath, field).set('').set(' ').double_click.send_keys :backspace
  rescue
    raise 'Не удалось удалить значение поля'
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

  def check_document_required
    expect(page).to have_xpath("//span[contains(@class,'is-required')]")
  rescue
    raise 'Документ не определен как обязательный'
  end

  def see_invalid_field(field_xpath)
    field_required = "//span[contains(@class,'is-required')]"
    field_invalid = "//span[contains(@class,'input_invalid')]"
    field_focus = "//span[contains(@class,'input_focused')]"
    textarea_required = " and contains(@class,'is-required')]"
    expect(page).to have_xpath("#{field_required}#{field_xpath} | #{field_focus}#{field_xpath} |
     #{field_invalid}#{field_xpath} | #{field_xpath[0...-1]}#{textarea_required}")
  rescue
    raise 'Не удалось увидеть ошибку'
  end


end
