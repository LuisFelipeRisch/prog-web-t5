class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :cart, dependent: :destroy

  before_create :initialize_cart

  def admin?
    self.is_admin
  end

  private

  def initialize_cart
    build_cart
  end
end
