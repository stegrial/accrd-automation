# encoding: UTF-8

require_relative '../../helpers/http_helper'
require_relative '../../features/support/utils'
require_relative 'accr_number_page.rb'
require 'capybara'

include HTTPHelper
include Utils
include SearchNumber


module ACCREditing

  # Note: use this function only if you do authorization with token
  def open_accr_edit_page(accr_id)
    begin
      url = "/accrd-ui/disclose/process/#{accr_id}"
      visit url
    rescue
      raise "Не удалось открыть сраницу реадактирования акредетива - #{accr_id}"
    end
  end

  # For accesses uses button name
  # Works with 3 buttons: 'Редактировать', 'Изменение суммы/срока', 'Отзыв аккредитива'
  def press_edit_button(action)
    begin
      find(:xpath, "//span[contains(text(), '#{action}')]").click
    rescue
      raise "Не удалось выполнить: #{action}"
    end
  end
end
