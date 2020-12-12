require "./src/depedency"
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

app = App.new "LTC_BRL"
p app.showValue