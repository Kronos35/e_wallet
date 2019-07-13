class ApplicationRecord < ActiveRecord::Base
  include ValidRegex
  self.abstract_class = true
end
