json.extract! transation, :id, :type, :date, :value, :representative_id, :store_id, :card, :time, :created_at, :updated_at
json.url transation_url(transation, format: :json)
