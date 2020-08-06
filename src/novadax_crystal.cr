require "./depedency"

module NovadaxCrystal
  class NovadaxAPI
    @acess_key : String | Nil
    @secret_key : String | Nil 

    def initialize(@acess_key = nil, @secret_key = nil)
      @url = "https://api.novadax.com"
    end

    def hasKeys?
      if(@acess_key.nil? || @secret.nil?)
        raise Exception.new("Need the API keys on this method")
      end
    end

    def signatureToGet
      hasKeys?

      @acess_key.downcase
    end

    def signatureToPost
      hasKeys?
    end

    def getRecentTrades(symbol : String, limit : String = "100")
      endpoint = "/v1/market/trades"
      qs = HTTP::Params.encode({"symbol" => symbol, "limit" => limit})
      client = HTTP::Client.get("#{@url}#{endpoint}?#{qs}")
      
      client.body
    end

  end
end