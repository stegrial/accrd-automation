require_relative '../../helpers/http_helper'
require_relative '../../features/support/utils'
require 'capybara'


include HTTPHelper
include Utils

module Search_number

  def open_search_number_page(user)
    url = "/search?token=#{HTTPHelper.get_token user}"
    puts url
    visit url
  end

  def press_find_button
    find(:xpath, "//button[@data-reactid='40']").click
  end

  def enter_accr_number(number)
    find(:xpath, "//input[@data-reactid='37']").set(number)
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
    find(:xpath, "//span[contains(@class, 'button__text')and contains(., 'contract_copy.pdf')]").click
  end

  def save_statement
    find(:xpath, "//span[contains(@class, 'button__text')and contains(., 'statement.pdf')]").click
  end

  def press_edit_button
    find(:xpath, "//span[contains(@class, 'button__text')and contains(., 'Редактировать')]").click
  end

end