class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    product = Product.find(params[:productId])
    cart_item = current_user.cart.add_product(product: product)

    if cart_item.save
      redirect_to root_path, notice: "Produto adicionado ao carrinho com sucesso!"
    else
      redirect_to root_path, alert: "Falha ao adicionar produto ao carrinho"
    end
  end
end
