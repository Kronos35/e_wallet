module ValidationHelper
  def visa_regex
    /^4[0-9]{12}(?:[0-9]{3})?$/
  end

  def mastercard_regex
    /^(?:5[1-5][0-9]{2}|222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720)[0-9]{12}$/
  end

  def amex_regex
    /^3[47][0-9]{13}/
  end

  def credit_card_regex
    case self.network
    when 'visa'
      visa_regex
    when 'mastercard'
      mastercard
    when 'american_express'
      amex_regex
    end
  end
end
