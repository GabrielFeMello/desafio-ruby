class Representative < ApplicationRecord
  belongs_to :store
  validates :name, presence: true
  validates :document, presence: true, uniqueness: true 

  def cpf
    return self.document.gsub(/(\d{3})(\d{3})(\d{3})(\d{2})/, '\1.\2.\3-\4')
  end
end
