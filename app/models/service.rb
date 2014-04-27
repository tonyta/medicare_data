class Service < ActiveRecord::Base
  has_many :provided_services
  has_many :providers, through: :provided_services
end
