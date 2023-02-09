require_relative "item_manager"
require_relative "ownable"

class Cart
  include ItemManager
  include Ownable

  def initialize(owner)
    self.owner = owner
    @items = []
  end

  def items
    # Override the items method of ItemManager so that the Cart's items become its own @items.
    # When a Cart instance has an Item instance, it just stores it in its own @items (Cart#add) without letting the owner authority transfer.
    @items
  end

  def add(item)
    @items << item
  end

  def total_amount
    @items.sum(&:price)
  end

  def check_out
    return if owner.wallet.balance < total_amount
    @items.each do |item|
      item.owner.wallet.deposit(owner.wallet.withdraw(item.price))
      item.owner = owner
    end
    items.clear
  end

end
