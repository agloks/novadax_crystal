require "./src/depedency"
require "./env"

novadax = NovadaxCrystal::NovadaxAPI.new ENV["ACESS_KEY"], ENV["SECRET_KEY"]
request = novadax.getCriptoDetail("LTC_BRL", "5")
data = CryptoDetail.from_json(request).to_h

p request
