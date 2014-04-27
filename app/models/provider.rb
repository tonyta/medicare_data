class Provider < ActiveRecord::Base
  has_many :provided_services
  has_many :services, through: :provided_services
end
