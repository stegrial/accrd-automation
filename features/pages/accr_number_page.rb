require_relative '../../helpers/http_helper'
require_relative '../../features/support/utils'
require 'capybara'


include HTTPHelper
include Utils

module Search_number

  def open_search_number_page(user)
    url = "/accr/search?token=#{HTTPHelper.get_token user}"
    puts url
    visit url
  end

  def press_find_button
    find(:xpath, "//button[@data-reactid='40' or @data-reactid='38']").click
  end

  def enter_search_value(search_value)
    find(:xpath, "//span[@data-reactid='35' or @data-reactid='33']//input").set('')
    find(:xpath, "//span[@data-reactid='35' or @data-reactid='33']//input").set(search_value)
  end

  def remember_new_number
    $new_generated_accr_number = find(:xpath, "//span[contains(@class, 'label__inner')and contains(., 'ACCD')]").text
  end

  def enter_no_exist_number
    no_exist_number = "#{$new_generated_accr_number[0...-1]}#{$new_generated_accr_number[-1].to_i+1}"
    find(:xpath, "//input[@data-reactid='37']").set(no_exist_number)
  end

  def redirect_to_full_name_search
    find(:xpath, "//a[@data-reactid='43']").click
  end

  def save_contract_copy
    find(:xpath, "//span[@class='button__text' and text()='contract_copy.pdf']").click
  end

  def save_statement
    find(:xpath, "//span[@class='button__text' and text()='statement.pdf']").click
  end

  def press_edit_button
    find(:xpath, "//span[contains(@class, 'button__text')and contains(., 'Редактировать')]").click
  end

  def change_amount_accr(amount_accr)
    find(:xpath, "//input[@value='10']").set('')
    find(:xpath, "//input[@value='10']").set(amount_accr)
  end

  def confirm_changes
    find(:xpath, "//button[contains(@class, 'new-accreditive__submit-button')]").click
  end

  def press_confirm_button
    find(:xpath, "//span[contains(@class, 'button__text')and contains(., 'Подтвердить')]").click
  end

  # def remember_account_balance проверка что деньги сняты со счета
  #   $account_balance = find(:xpath, "").text
  # end

end