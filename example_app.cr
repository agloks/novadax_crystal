require "./src/depedency"
require "./src/email"
require "./env"

class App
  def initialize(@symbol : String)
    @novadax = NovadaxCrystal::NovadaxAPI.new ENV["ACESS_KEY"], ENV["SECRET_KEY"]
  end
  
  def isMoreThen(value : Float64) : Bool
    request = @novadax.getCriptoDetail(@symbol)
    data = CryptoDetail.from_json(request).data
    
    data.ask.to_f > value ? true : false
  end
    
  def isLessThen(value : Float64) : Bool
    request = @novadax.getCriptoDetail(@symbol)
    data = CryptoDetail.from_json(request).data
    
    data.ask.to_f < value ? true : false
  end
  
  def isEqual(value : Float64) : Bool
    request = @novadax.getCriptoDetail(@symbol)
    data = CryptoDetail.from_json(request).data
    
    data.ask.to_f == value ? true : false
  end

  def showValue
    request = @novadax.getCriptoDetail(@symbol)
    
    CryptoDetail.from_json(request).to_h
  end
end

app = App.new "ETH_BRL"
value = 2849.00

unless app.isMoreThen value
  p "app sleeping 60 seconds..."
  sleep 60.seconds
end

p Mail::CryptoGotValue.new("Hacker", "ETH_BRL", app.showValue.dig("data", "ask").to_s, "hacktonironhacker@gmail.com").deliver