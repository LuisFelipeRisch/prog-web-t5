class CartProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart_product,      only: %i[ destroy ]
  before_action :check_user_can_remove, only: %i[ destroy ]

  def destroy
    @cart_product = CartProduct.find(params[:id])
    @cart_product.destroy

    redirect_to cart_path(current_user.cart), notice: 'O produto foi removido com sucesso do seu carrinho!'
  end

  private
    def set_cart_product
      @cart_product = CartProduct.find(params[:id])
    end

    def check_user_can_remove
      if current_user != @cart_product.user
        render "errors/forbidden", status: :forbidden
      end
    end
end
