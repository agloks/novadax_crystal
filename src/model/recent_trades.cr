class RecentTrades
  include JSON::Serializable

  property code : String

  property data : Array(Data)

  property message : String

  def to_t
  {
    code: @code,
    data: @data.map &.to_t,
    message: @message
  }
  end
end

class Data
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
end