class Representative < ApplicationRecord
  belongs_to :store
  validates :document, :name, presence: true

  def cpf
    return self.document.gsub(/(\d{3})(\d{3})(\d{3})(\d{2})/, '\1.\2.\3-\4')
  end
end
