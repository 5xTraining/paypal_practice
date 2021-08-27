class Cart
  attr_reader :items

  def self.from_hash(hash)
    if hash && hash["items"]
      items = hash["items"].map { |item|
        CartItem.new(item["product_id"], item["quantity"])
      }
      Cart.new(items)
    else
      Cart.new
    end
  end

  def initialize(items = [])
    @items = items
  end

  def add_item(id)
    found_item = @items.find { |item| item.product_id == id }

    if found_item
      found_item.increment!
    else
      @items << CartItem.new(id)
    end
  end

  def empty?
    @items.empty?
  end

  def total
    t = @items.reduce(0) { |acc, item| acc + item.total }
    t = t * 0.9 if is_xmas?
    t
  end

  def serialize
    t = @items.map { |item|
      { "product_id" => item.product_id, "quantity" => item.quantity }
    }

    { "items" => t }
  end

  private
  def is_xmas?
    Time.now.month == 12 && Time.now.day == 25
  end
end
