class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
    @products.each do |p|
      puts p.title
    end
  end
end
