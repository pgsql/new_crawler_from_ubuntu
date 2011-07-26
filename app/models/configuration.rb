class Configuration < ActiveRecord::Base
  has_many :results
  scope :activated, where(:active => true)
end
