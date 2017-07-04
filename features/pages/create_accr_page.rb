require 'capybara'

module Create

  def open_page
    visit '/new'
  end

  def search(search_string)
    fill_in 'lst-ib', with: search_string
  end
end