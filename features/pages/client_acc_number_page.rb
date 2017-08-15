require_relative '../../helpers/http_helper'
require_relative '../../features/support/utils'
require 'capybara'


include HTTPHelper
include Utils

module Search_bill

  def open_search_bill_page(user)
    url = "/client/search?token=#{HTTPHelper.get_token user}"
    puts url
    visit url
  end


end