# encoding: UTF-8

require_relative '../../helpers/http_helper'
require_relative '../../features/support/utils'
require 'capybara'

include HTTPHelper
include Utils


module Search_bill

  def open_search_bill_page(user)
    begin
      url = "/accrd-ui/client/search?ad-token=#{HTTPHelper.get_token user}"
      puts url
      visit url
    rescue
      raise 'Не удалось открыть страницу с формой поиска клиента по номеру счета'
    end
  end


end