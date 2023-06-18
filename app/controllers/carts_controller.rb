class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: %i[ show ]
  before_action :check_user_can_access, only: %i[ show ]

  def show
  end

  private
    def set_cart
      @cart = Cart.find(params[:id])
    end

    def check_user_can_access
      if current_user.cart != @cart
        render "errors/forbidden", status: :forbidden
      end
    end
end
