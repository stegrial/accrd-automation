require_relative '../../helpers/http_helper'
require_relative '../../features/support/utils'
require 'capybara'
require 'roo-xls'

include HTTPHelper
include Utils


module Compare_data

  def compare_account_number(number, file)
    puts (file.cell(53, 6, sheet = 'ФОРМА')).to_s
    file.cell(53, 6, sheet = 'ФОРМА').to_s.should == number
  end

  def compare_seller_full_name(name, file)
    puts (file.cell(39, 3, sheet = 'ФОРМА')).to_s
    file.cell(39, 3, sheet = 'ФОРМА').to_s.should == name
  end

  def compare_birth_date(date, file)
    begin
      puts (file.cell(43, 3, sheet = 'ФОРМА')).to_s
      file.cell(43, 3, sheet = 'ФОРМА').to_s.should == date
    rescue
      raise 'Дата рождения не соответствует значению из печатной формы заявки'
    end
  end

  def compare_inn_number_dev(number, file)
    puts (file.cell(40, 11, sheet = 'ФОРМА')).to_s
    file.cell(40, 11, sheet = 'ФОРМА').to_s.should == number
  end

  def compare_name_seller_org(name_org, file)
    puts (file.cell(39, 3, sheet = 'ФОРМА')).to_s
    file.cell(39, 3, sheet = 'ФОРМА').to_s.should == name_org
  end


end