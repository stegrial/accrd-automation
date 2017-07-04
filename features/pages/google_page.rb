require 'capybara'

module Search

  def search(search_string)
    fill_in 'lst-ib', with: search_string
  end
end