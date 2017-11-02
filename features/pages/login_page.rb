# encoding: UTF-8

require_relative '../../helpers/http_helper'
require_relative '../../features/support/utils'
require 'capybara'

include HTTPHelper
include Utils


module Login

  @@login_button = "//button[@name='login--button']"

  def open_login_page
    visit '/accrd-ui/accr/new'
  rescue
    raise 'Не удалось перейти на страницу авторизации'
  end

  def enter_login(login)
    find(:xpath, "//input[@name='login--login']").set(login)
  rescue
    raise 'Не удалось заполнить поле - Логин'
  end

  def enter_password(password)
    find(:xpath, "//input[@name='login--password']").set(password)
  rescue
    raise 'Не удалось заполнить поле - Пароль'
  end

  def press_login_button
    find(:xpath, "//button[@name='login--button']").click
  rescue
    raise 'Не удалось нажать на кнопку - Войти'
  end

  def authorize?
    page.should have_xpath("//button[@name='login--button']")
    page.should have_text('Необходимо авторизоваться')
  end

  def login_page?
    page.should have_xpath("//button[@name='login--button']")
  rescue
    raise 'Страница авторизации не найдена'
  end

end