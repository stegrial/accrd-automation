# encoding: UTF-8

require_relative '../../helpers/http_helper'
require_relative '../../features/support/utils'
require 'capybara'

include HTTPHelper
include Utils


module Login

  def open_login_page
    begin
      visit '/accr/new'
    rescue
      raise 'Не удалось открыть страницу авторизации'
    end
  end

  def press_login_button
    begin
      find(:xpath, "//button[@data-reactid='44']").click
    rescue
      raise 'Не удалось нажать на кнопку - Войти'
    end
  end

  def enter_login(login)
    begin
      find(:xpath, "//input[@data-reactid='33']").set(login)
    rescue
      raise 'Не удалось заполнить поле - Логин'
    end
  end

  def enter_password(password)
    begin
      find(:xpath, "//input[@data-reactid='41']").set(password)
    rescue
      raise 'Не удалось заполнить поле - Пароль'
    end
  end


end