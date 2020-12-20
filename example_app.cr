require "./src/depedency"
require "./src/email"
require "cli"

class NovaHandlers
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

  #Only for debug purpose
  def showValue
    request = @novadax.getCriptoDetail(@symbol)
    
    CryptoDetail.from_json(request).to_h
  end
end

module CLI
  class MainCommand < ::Cli::Supercommand
    # command "s", aliased: "start"

    class App < ::Cli::Command
      class Options
        string ["-s", "--symbol"], desc: "symbol: [LTC_BRL, ETHC_BRL, etc]"
        string ["-a", "--above-value"], desc: "price to be notified when get above", default: "-1.0"
        string ["-d", "--down-value"], desc: "price to be notified when get down", default: "-1.0"
      end

      def run
        symbol = options.symbol
        app = NovaHandlers.new symbol
        
        while true
          if app.isMoreThen options.above_value.to_f
            Mail::CryptoGotValue.new("Bull", symbol, app.showValue.dig("data", "ask").to_s, "hackatonironhacker@gmail.com").deliver
            break
          elsif app.isLessThen options.down_value.to_f
            Mail::CryptoGotValue.new("Bear", symbol, app.showValue.dig("data", "ask").to_s, "hackatonironhacker@gmail.com").deliver
            break
          else
            p "app sleeping 60 seconds..."
            sleep 60.seconds
          end
        end

        #Sucess = 1
        1
      rescue e : Exception
        exit! e.message, error: true
      end
    end
  end
end   

# app = NovaHandlers.new "ETH_BRL"
# p app.showValue

p CLI::MainCommand.run ARGV