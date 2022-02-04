class Admin::DashboardController < ApplicationController
  def show
    @productcount = Product.count
    @categorycount = Category.count
  end

end
