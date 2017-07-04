require 'capybara'

module Login

  def do_login(user_name, password)
    fill_in 'lst-ib', with: user_name
  end
end