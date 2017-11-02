# encoding: UTF-8

require_relative '../../helpers/http_helper'
require_relative '../../features/support/utils'
require_relative 'accr_number_page.rb'
require 'capybara'

include HTTPHelper
include Utils
include SearchNumber


module ACCRList

  def open_accr_list_page(user)
    begin
      url = "/accrd-ui/disclose/process/?ad-token=#{HTTPHelper.get_token user}"
      visit url
    rescue
      raise 'Не удалось открыть сраницу со списком акредетивов'
    end
  end

  # click 'edit' button for random accr
  def edit_accr(action)
    begin
      all(:xpath, "//span[contains(text(), '#{action}')]")[0].click
    rescue
      raise 'Не удалось редактировать акредетив'
    end
  end
end
