class CartProduct < ApplicationRecord
  belongs_to :cart, required: true
  belongs_to :product, required: true

  before_create :set_total_value

  delegate :user, to: :cart
  delegate :name, :description, :store, to: :product

  def set_total_value
    self.total_value = self.product&.total_value
  end
end
