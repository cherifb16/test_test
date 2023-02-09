require_relative "item_manager"
require_relative "wallet"

class User
  include ItemManager
  

  attr_accessor :name
  attr_reader :wallet

  def initialize(name)
    @name = name
    @wallet = Wallet.new(self) # When a User instance or an instance of a class that inherits from User is created, it has a wallet with itself as its owner.
  end

end
