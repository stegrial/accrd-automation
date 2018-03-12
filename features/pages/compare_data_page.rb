# encoding: UTF-8

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

  def compare_seller_full_name(full_name, file)
    puts (file.cell(39, 3, sheet = 'ФОРМА')).to_s
    file.cell(39, 3, sheet = 'ФОРМА').to_s.should == full_name
    file.cell(35, 6, sheet = 'ФОРМА').to_s.should include full_name
  end

  def compare_inn_number_dev(number, file)
    puts (file.cell(40, 11, sheet = 'ФОРМА')).to_s
    file.cell(40, 11, sheet = 'ФОРМА').to_s.should == number
  end

  def compare_name_seller_org(name_org, file)
    puts (file.cell(39, 3, sheet = 'ФОРМА')).to_s
    file.cell(39, 3, sheet = 'ФОРМА').to_s.should == name_org
    file.cell(35, 6, sheet = 'ФОРМА').to_s.should include name_org
  end

  def compare_ogrn_number(number, file)
    puts (file.cell(40, 3, sheet = 'ФОРМА')).to_s
    file.cell(40, 3, sheet = 'ФОРМА').to_s.should == number
  end

  def compare_address_seller_org(address, file)
    puts (file.cell(48, 6, sheet = 'ФОРМА')).to_s
    file.cell(48, 6, sheet = 'ФОРМА').to_s.should == address
  end

  def compare_inn_number_ind(number, file)
    puts (file.cell(40, 11, sheet = 'ФОРМА')).to_s
    file.cell(40, 11, sheet = 'ФОРМА').to_s.should == number
  end

  def compare_passport_series(series, file)
    puts (file.cell(45, 5, sheet = 'ФОРМА')).to_s
    file.cell(45, 5, sheet = 'ФОРМА').to_s.should == series
  end

  def compare_passport_number(number, file)
    puts (file.cell(45, 9, sheet = 'ФОРМА')).to_s
    file.cell(45, 9, sheet = 'ФОРМА').to_s.should == number
  end

  def compare_issued_by(organization, file)
    puts (file.cell(46, 6, sheet = 'ФОРМА')).to_s
    file.cell(46, 6, sheet = 'ФОРМА').to_s.should == organization
  end

  def compare_issued_date(date, file)
    puts (file.cell(46, 11, sheet = 'ФОРМА')).to_s
    file.cell(46, 11, sheet = 'ФОРМА').to_s.should == date
  end

  def compare_birth_date(date, file)
    begin
      puts (file.cell(43, 3, sheet = 'ФОРМА')).to_s
      file.cell(43, 3, sheet = 'ФОРМА').to_s.should == date
    rescue
      raise 'Дата рождения не соответствует значению из печатной формы заявки'
    end
  end

  def compare_birth_place(birth_place, file)
    puts (file.cell(43, 10, sheet = 'ФОРМА')).to_s
    file.cell(43, 10, sheet = 'ФОРМА').to_s.should == birth_place
  end

  def compare_citizenship(citizenship, file)
    if citizenship == 'РОССИЯ'
      citizenship = 'РФ'
      puts (file.cell(44, 3, sheet = 'ФОРМА')).to_s
      file.cell(44, 3, sheet = 'ФОРМА').to_s.should == citizenship
    else
      puts (file.cell(44, 9, sheet = 'ФОРМА')).to_s
      file.cell(44, 9, sheet = 'ФОРМА').to_s.should == citizenship
    end
  end

  def compare_registration_address(address, file)
    puts (file.cell(48, 6, sheet = 'ФОРМА')).to_s
    file.cell(48, 6, sheet = 'ФОРМА').to_s.should == address
  end

  def compare_bic_number(number, file)
    puts (file.cell(55, 11, sheet = 'ФОРМА')).to_s
    file.cell(55, 11, sheet = 'ФОРМА').to_s.should == number
  end

  def compare_accr_lifetime(days, file)
    puts (file.cell(31, 5, sheet = 'ФОРМА')).to_s
    file.cell(31, 5, sheet = 'ФОРМА').to_s.should == (Date.today + days.to_i).strftime('%d.%m.%Y')
  end

  def compare_salary_account(money_number, file)
    puts (file.cell(27, 3, sheet = 'ФОРМА')).to_s
    file.cell(27, 3, sheet = 'ФОРМА').to_s[-4..-1].should == money_number[-4..-1]
  end

  def compare_second_buyer_name(full_name, file)
    puts (file.cell(34, 6, sheet = 'ФОРМА')).to_s
    file.cell(34, 6, sheet = 'ФОРМА').to_s.should include full_name
  end

  def compare_amount_accr(amount, file)
    puts (file.cell(26, 2, sheet = 'ФОРМА')).to_s
    file.cell(26, 2, sheet = 'ФОРМА').to_s.should == "#{(amount+',00')[0...4]}"
  end

  def compare_address_real_estate(address, file)
    puts (file.cell(36, 6, sheet = 'ФОРМА')).to_s
    file.cell(36, 6, sheet = 'ФОРМА').to_s.should == address
  end

  def compare_contract_number(number, file)
    puts (file.cell(33, 6, sheet = 'ФОРМА')).to_s
    file.cell(33, 6, sheet = 'ФОРМА').to_s.should include number
  end

  def compare_contract_date(date, file)
    puts (file.cell(33, 6, sheet = 'ФОРМА')).to_s
    file.cell(33, 6, sheet = 'ФОРМА').to_s.should include date
  end

  def compare_contract_name(name, file)
    puts (file.cell(33, 6, sheet = 'ФОРМА')).to_s
    file.cell(33, 6, sheet = 'ФОРМА').to_s.should include name
  end

  def compare_conditions(conditions, file)
    puts (file.cell(59, 3, sheet = 'ФОРМА')).to_s
    file.cell(59, 3, sheet = 'ФОРМА').to_s.should == conditions
  end


end