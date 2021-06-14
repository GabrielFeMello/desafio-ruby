class Transation < ApplicationRecord
  belongs_to :representative
  belongs_to :store
end
