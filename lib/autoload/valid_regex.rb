module ValidRegex
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end

  module ClassMethods
    def visa_regex
      /\A4[0-9]{12}(?:[0-9]{3})?\z/
    end

    def mastercard_regex
      /\A(?:5[1-5][0-9]{2}|222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720)[0-9]{12}\z/
    end

    def amex_regex
      /\A3[47][0-9]{13}\z/
    end

    def expire_date_regex
      /\A(0?[1-9]|1[012])\/([0-9]{2})\z/
    end
  end
  
  module InstanceMethods
    
  end
  
  
end