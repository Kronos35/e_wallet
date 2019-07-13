module Askable
  extend ActiveSupport::Concern
  
  included do
    def self.set_askers(keys)
      keys.each do |key|
        define_method :"#{key}?" do
          network == key.to_s
        end
      end
    end
  end
end


