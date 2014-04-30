class Service < ActiveRecord::Base
  has_many :provided_services
  has_many :providers, through: :provided_services

  def price_distribution(multiplier=1)
    price_occur = price_occurances(multiplier)
    max = price_occur.keys.max
    array = Array.new(max, 0)
    price_occurances(multiplier).each do |price_occur|
      array[price_occur[0].to_i] = price_occur[1]
    end
    array
  end

  def price_occurances(multiplier=1)
    price_num_raw.each_with_object(Hash.new(0)) do |price_num, occur|
      occur[price_num[0].to_i / multiplier] += price_num[1]
    end
  end

  def price_num_raw
    self.provided_services.pluck(:average_submitted_chrg_amt, :line_srvc_cnt)
  end

  private

  def with_percents(array)
    total = array.inject(:+).to_f
    array.map{|e| e / total}
  end
end
