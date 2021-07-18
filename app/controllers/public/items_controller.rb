class Public::ItemsController < ApplicationController
	before_action :authenticate_customer!
	def index
		@items = Item.all

		if params[:search].present?
			@items = @items.where('name LIKE?', "%#{params[:search]}%")
		end
	end

	def show
		@item = Item.find(params[:id])
		@cartitem = CartItem.new
	end
end
