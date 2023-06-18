class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :authenticate_user!,    only: %i[ new edit update create destroy ]
  before_action :check_user_permission, only: %i[ new edit update create destroy ]

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to root_url, notice: "Produto criado com sucesso!" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to root_url, notice: "Produto atualizado com sucesso!" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to root_url, notice: "Produto deletado com sucesso!" }
    end
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :total_value, :store_id)
    end

    def check_user_permission
      if !current_user.admin?
        render "errors/forbidden", status: :forbidden
      end
    end
end
