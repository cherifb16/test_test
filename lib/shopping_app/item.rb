require_relative "ownable"
class Item
  include Ownable
  attr_reader :name, :price

  @@instances = []

  def initialize(name, price, owner=nil)
    @name = name
    @price = price
    self.owner = owner

    # When an Item instance is created, the Item instance (self) is stored in a class variable named @@insntances.
    @@instances << self
  end

  def label
    { name: name, price: price }
  end

  def self.all
    #　Returns @@instances ==> Item.all returns all Item instances created so far.
    @@instances
  end

end
