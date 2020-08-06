require "./src/depedency"
require "./env"

novadax = NovadaxCrystal::NovadaxAPI.new
request = novadax.getRecentTrades("LTC_BRL", "2")
data = RecentTrades.from_json(request).to_h

p data