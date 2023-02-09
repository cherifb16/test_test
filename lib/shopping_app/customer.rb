require_relative "user"
require_relative "cart"

class Customer < User
  attr_reader :cart

  def initialize(name)
    super(name)
    @cart = Cart.new(self) # When a Customer instance is created, it has a cart with itself as the owner.
  end

end
