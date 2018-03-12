# encoding: UTF-8

require_relative '../../helpers/http_helper'
require_relative '../../features/support/utils'
require_relative 'create_accr_dev_page'
require 'capybara'

include Create_dev
include HTTPHelper
include Utils


module Create_cmc

  def fill_income_account_number(number)
    begin
      fill_in('about-accreditive--commision-account', with: '')
      fill_in('about-accreditive--commision-account', with: number)
    rescue
      raise 'Не удалось заполнить поле - Счет доходов'
    end
  end

  def fill_profit_center_code(code)
    begin
      fill_in('about-accreditive--profit-center', with: code)
    rescue
      raise 'Не удалось заполнить поле - Код профит-центра'
    end
  end

  def fill_commission_amount(amount)
    begin
      fill_in('about-accreditive--commision', with: '')
      fill_in('about-accreditive--commision', with: amount)
    rescue
      raise 'Не удалось заполнить поле - Сумма комиссии'
    end
  end

  def fill_branch(number)
    begin
      fill_in('about-accreditive--branch-code', with: '')
      fill_in('about-accreditive--branch-code', with: number)
    rescue
      raise 'Не удалось заполнить поле - Бранч отделения'
    end
  end


end
