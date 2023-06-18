class HomeController < ApplicationController
  def index
    @products = Product.where("1=1").order('RANDOM()')
  end
end
