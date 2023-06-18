class Store < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name, presence: true

  def add_product(product_attributes)
    self.products.build(product_attributes)
  end
end
