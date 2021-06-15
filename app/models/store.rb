class Store < ApplicationRecord
  has_many :transations
  has_many :representatives
  validates :name, presence: true

  def get_full_value
    full_value = 0
    positive_values = [1,4,5,6,7,8]
    self.transations.each do |transation|
      positive_values.include?(transation.transation_type) ? full_value+=transation.value : full_value-=transation.value
    end
    return full_value
  end


end
