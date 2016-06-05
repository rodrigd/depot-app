class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  
=begin
 per p. 120 we need a smart add_procudt method in our Cart, one that checks whether our list already includes the product we're adding
=end

def add_product(product_id)
  current_item = line_items.find_by(product_id: product_id)
  if current_item
    current_item.quantity += 1
  else
    current_item = line_items.build(product_id: product_id)
  end
  current_item
end

def total_price
  line_items.to_a.sum { |item| item.total_price}
end

end