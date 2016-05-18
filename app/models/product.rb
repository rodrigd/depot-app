# I am entering a comment, saving it, then checking it into github
# another comment
# yet another comment
class Product < ActiveRecord::Base
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true 
  validates :title, :length => {:minimum => 10}
  
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG, or PNG image.'
  }
  
  def valid
    puts 'running the validate method'
    return false
  end
  
  def self.latest
    Product.order(:updated_at).last
  end
end
