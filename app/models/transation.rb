class Transation < ApplicationRecord
  belongs_to :representative
  belongs_to :store
  validates :transation_type, :representative_id, :store_id, :date, :value, :time, :card, presence: true

  def type_name
    transationsTypes = ["Débito" ,
    "Boleto",
    "Financiamento",
    "Crédito",
    "Recebimento Empréstimo",
    "Vendas",
    "Recebimento TED",
    "Recebimento DOC",
    "Aluguel"]

    return transationsTypes[self.transation_type-1]
  end


  def type_call
    positive_values = [1,4,5,6,7,8]
    return positive_values.include?(self.transation_type) ? "green" : "red"
  end

  def representative_cpf
    return self.representative.cpf
  end


end
