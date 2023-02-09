require "kosi"
require_relative "item"

# Include this module to be able to manipulate the Item instances that you own.
module ItemManager
  def items # This function returns all Item instances owned by itself (of which it is the owner).
    Item.all.select{|item| item.owner == self }
  end

  def pick_items(number, quantity) # This function returns all the Item instances owned by itself.
    items = stock.find{|stock| stock[:number] == number }&.dig(:items)
    return if items.nil? || items.size < quantity
    items.slice(0, quantity)
  end

  def items_list # This function outputs the inventory status of the Item instances owned by itself in the form of a table with the columns ["number", "item name", "amount", "quantity"].
    kosi = Kosi::Table.new({header: %w{Number ItemName Amount Quantity}}) # Here, a gem called kosi is used.
    print kosi.render(
      stock.map do |stock|
        [
          stock[:number],
          stock[:label][:name],
          stock[:label][:price],
          stock[:items].size
        ]
      end
    )
  end

  private

  def stock # This function returns the inventory status of the Item instance owned by itself.
    items
      .group_by{|item| item.label } # Classify Item instances that return the same value in Item#label.
      .map.with_index do |label_and_items, index|
        {
          number: index,
          label: {
            name: label_and_items[0][:name],
            price: label_and_items[0][:price],
          },
          items: label_and_items[1], # Store the classified Item instances in this items.
        }
      end
  end

end
