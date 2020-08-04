require "./depedency"

module NovadaxCrystal
  class NovadaxAPI
    
    def initialize
      @url = "https://api.novadax.com"
    end

    def getRecentTrades(symbol : String, limit : String = "100")
      endpoint = "/v1/market/trades"
      qs = HTTP::Params.encode({"symbol" => symbol, "limit" => limit})
      client = HTTP::Client.get("#{@url}#{endpoint}?#{qs}")
      
      client.body
    end

  end
end