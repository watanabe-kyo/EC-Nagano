class Admin::OrdersController < ApplicationController

	def index
		@orders = Order.all
	end

	def show
		@order = Order.find(params[:id])
	end

	def update
		@order = Order.find(params[:id])
		@order.update(order_params)
		if @order.status == "入金確認"
			@order.order_details.update_all(making_status: "製作待ち")
		end
		redirect_to request.referer
	end

	private
	def order_params
		params.require(:order).permit(:status)
	end

end
