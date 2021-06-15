require 'rails_helper' 
describe Transation do 
 it "é válido quando todos os campos preenchidos" do
  sample_CNAB = "3201903010000014200096206760174753****3153153453JOÃO MACEDO   BAR DO JOÃO          "

  representative = Representative.new()
  transation = Transation.new() 

  content = {}
  content["transation"] = {}
  content["representative"] = {}
  content["store"] = {}

  content["transation"]["transation_type"] = sample_CNAB[0].to_i
  content["transation"]["date"] = sample_CNAB[1..8]
  content["transation"]["card"] = sample_CNAB[30..41]
  content["transation"]["time"] = Time.at(sample_CNAB[42..47].to_i)
  content["transation"]["value"] = sample_CNAB[9..18].to_i/100

  content["representative"]["name"] = sample_CNAB[48..61]
  content["representative"]["document"] = sample_CNAB[19..29]

  content["store"]["name"] = sample_CNAB[62..80]

  store = Store.new(content['store'])
  store.save
  representative = Representative.new(content["representative"])
  representative.store_id = store.id
  representative.save

  transation.transation_type = content["transation"]["transation_type"]
  transation.date = content["transation"]["date"]
  transation.card = content["transation"]["card"]
  transation.time = content["transation"]["time"]
  transation.value = content["transation"]["value"]
  transation.store_id = store.id
  transation.representative_id = representative.id
   
  expect(transation).to be_valid 
 end
end