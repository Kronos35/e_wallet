module Askable
  extend ActiveSupport::Concern
  
  included do
    def self.set_askers(keys)
      keys.each { |key| 
        define_method(:"#{key}?") { 
          brand == key.to_s } }
    end
  end
end


