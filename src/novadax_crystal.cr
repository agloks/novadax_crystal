require "./depedency"
require "openssl/hmac"

module NovadaxCrystal
  class NovadaxAPI
    @acess_key : String | Nil
    @secret_key : String | Nil 

    def initialize(@acess_key = nil, @secret_key = nil)
      @url = "https://api.novadax.com"
    end

    def hasKeys?
      if(@acess_key.nil? || @secret_key.nil?)
        raise Exception.new("Need the API keys on this method, pass them as paramater on construct")
      end
    end

    def signatureToGet(endpoint : String, qs : String) : HTTP::Headers
      hasKeys?

      # TODO: API says to use local time in milliseconds
      # Maybe something like timestamp - Time::Location::Fixed(milliseconds of your zone) would work
      timestamp = Time.utc.to_unix_ms
      signStr = makeHash "GET", endpoint, qs, timestamp

      headers = HTTP::Headers.new
      headers.add("X-Nova-Access-Key", @acess_key.as(String))
      headers.add("X-Nova-Signature", signStr)
      headers.add("X-Nova-Timestamp", timestamp.to_s)

      headers
    end

    def makeHash(method : String, endpoint : String, qs : String, timestamp : Int32 | Int64) : String    
      #FORMAT: {Request Method}\n{Request URL}\n{Sorted Query Parameters}\n{TimeStamp}
      signStr = "#{method.upcase}\n#{endpoint}\n#{qs}\n#{timestamp}"
      algorithm = OpenSSL::Algorithm::SHA256
    
      OpenSSL::HMAC.hexdigest algorithm, @secret_key.as(String), signStr
    end

    def signatureToPost(form_data)
      hasKeys?
    end

    def getRecentTrades(symbol : String, limit : String = "100")
      endpoint = "/v1/market/trades"
      qs = HTTP::Params.encode({"limit" => limit, "symbol" => symbol}) # IMPORTANT: Always put the keys in order ascedent by ascii
      headers = signatureToGet endpoint, qs
      client = async { HTTP::Client.get(url: "#{@url}#{endpoint}?#{qs}", headers: headers) }
      
      (await client).body
    end

    def getCriptoDetail(symbol : String, limit : String = "100")
      endpoint = "/v1/market/ticker"
      qs = HTTP::Params.encode({"limit" => limit, "symbol" => symbol}) # IMPORTANT: Always put the keys in order ascedent by ascii
      headers = signatureToGet endpoint, qs
      client = async { HTTP::Client.get(url: "#{@url}#{endpoint}?#{qs}", headers: headers) }
      
      (await client).body
    end
  end
end