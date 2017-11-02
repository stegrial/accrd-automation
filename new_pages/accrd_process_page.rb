# encoding: UTF-8

require_relative '../../helpers/http_helper'
require_relative '../../features/support/utils'
require_relative 'accr_number_page.rb'
require 'capybara'

include HTTPHelper
include Utils
include SearchNumber

# This module for accrd editing page
module ProcessPage

  # Go to accrd list
  # @param [String] user
  def open_accrd_list_page(user)
    url = "/accrd-ui/disclose/process/?ad-token=#{HTTPHelper.get_token user}"
    visit url
  rescue
    raise 'Не удалось открыть сраницу со списком акредетивов'
  end

  # Go to on special accrd use for it accrd id
  # Note: use this function only if you do authorization with token
  # @param [String] accr_id
  def open_accrd_detailed_page(accr_id)
    url = "/accrd-ui/disclose/process/#{accr_id}"
    visit url
  rescue
    raise "Не удалось открыть сраницу реадактирования акредетива - #{accr_id}"
  end

  # click 'edit' button for first accrd in list.
  # Need use before `press_edit_button` method.
  def press_edit(action)
    all(:xpath, "//span[contains(text(), '#{action}')]")[0].click
  rescue
    raise 'Не удалось редактировать акредетив'
  end

end





