require_relative '../../helpers/http_helper'
require_relative '../../features/support/utils'
require 'capybara'


include HTTPHelper
include Utils

module Search_full_name

  def open_search_full_name_page(user)
    url = "/disclose/search?token=#{HTTPHelper.get_token user}"
    puts url
    visit url
  end

  def press_attach_documents_button
    first(:xpath, "//span[text()='Приложить документы']").click
  end

  def open_attach_documents_page(user)
    url = "/disclose/search/pack/#{$new_generated_accr_number}?token=#{HTTPHelper.get_token user}"
    puts url
    visit url
  end

end