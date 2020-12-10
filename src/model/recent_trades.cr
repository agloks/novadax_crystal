class CryptoDetail
  include JSON::Serializable

  property code : String
  property data : CryptoDetailData
  property message : String

  def to_t
  {
    code: @code,
    data: @data.map &.to_t,
    message: @message
  }
  end

  def to_h
    {
      "code" => @code,
      "data" => @data.to_h,
      "message" => @message
    }
    end
end

class RecentTrades
  include JSON::Serializable

  property code : String
  property data : Array(RecentTradesData)
  property message : String

  def to_t
  {
    code: @code,
    data: @data.map &.to_t,
    message: @message
  }
  end

  def to_h
    {
      "code" => @code,
      "data" => @data.map &.to_h,
      "message" => @message
    }
    end
end

class RecentTradesData
  include JSON::Serializable

  property amount : String
  property price : String
  property side : String
  property timestamp : Int32 | Int64

  def to_t
  {
    amount: @amount,
    price: @price,
    side: @side,
    timestamp: @timestamp
  }
  end

  def to_h
    {
      "amount" => @amount,
      "price" => @price,
      "side" => @side,
      "timestamp" => @timestamp
    }
  end
end

class CryptoDetailData
  include JSON::Serializable

  property ask : String
  property bid : String
  property lastPrice : String
  property baseVolume24h : String
  property high24h : String
  property low24h : String
  property open24h : String
  property quoteVolume24h : String
  property symbol : String
  property timestamp : Int32 | Int64

  def to_t
  {
    ask: @ask,
    bid: @bid,
    lastPrice: @lastPrice,
    baseVolume24h: @baseVolume24h,
    high24h: @high24h,
    low24h: @low24h,
    open24h: @open24h,
    quoteVolume24h: @quoteVolume24h,
    symbol: @symbol,
    timestamp: @timestamp
  }
  end

  def to_h
    {
      "ask" => @ask,
      "bid" => @bid,
      "lastPrice" => @lastPrice,
      "baseVolume24h" => @baseVolume24h,
      "high24h" => @high24h,
      "low24h" => @low24h,
      "open24h" => @open24h,
      "quoteVolume24h" => @quoteVolume24h,
      "symbol" => @symbol,
      "timestamp" => @timestamp
    }
  end
end