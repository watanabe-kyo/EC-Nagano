class Public::OrdersController < ApplicationController
	before_action :authenticate_customer!
	def new
		@order = Order.new
		@addresses = current_customer.addresses
	end

	def confirm
		@cartitems = current_customer.cart_items
		@order = Order.new
		@order.customer_id = current_customer.id
		@order.shipping_cost = 500
		@order.payment_method = params[:order][:payment_method]

		@order.total_payment = 0
		current_customer.cart_items.each do |cartitem|
			@order.total_payment += ((cartitem.item.price * 1.1) * cartitem.amount)
		end
		@order.total_payment += @order.shipping_cost

		if params[:order][:address_option] == "0"
			@order.postal_code = current_customer.postal_code
			@order.address = current_customer.address
			@order.name = current_customer.last_name + current_customer.first_name
		elsif params[:order][:address_option] == "1"
			address = Address.find(params[:order][:jusyo])
			@order.postal_code = address.postal_code
			@order.address = address.address
			@order.name = address.name
		elsif params[:order][:address_option] =="2"
			@order.postal_code = params[:order][:postal_code]
			@order.address = params[:order][:address]
			@order.name = params[:order][:name]
			@address = Address.new
			@address.postal_code = params[:order][:postal_code]
			@address.address = params[:order][:address]
			@address.name = params[:order][:name]
			@address.customer_id = current_customer.id
			@address.save
		end
	end

	def thanks
	end

	def create
		@order = Order.new(order_params)
		@order.customer_id = current_customer.id
		@order.postal_code = params[:order][:postal_code]
		@order.address = params[:order][:address]
		@order.name = params[:order][:name]

		p "aaaa"
		p @order
		p "aaaa"

		# @order.shipping_cost = @order.shipping_cost.to_i
		# @order.total_payment = @order.total_payment.to_i
		# @order.payment_method = @order.payment_method.to_i

		# p "aaaa"
		# p @order
		# p "aaaa"

		unless @order.save
			@addresses = current_customer.addresses
			flash[:error] = '注文失敗！'
			render :new and return
		end

		@cartitems = current_customer.cart_items
		@cartitems.each do |cartitem|
			orderdetail = OrderDetail.new
			orderdetail.order_id = @order.id
			orderdetail.item_id = cartitem.item_id
			orderdetail.price = cartitem.item.price
			orderdetail.amount = cartitem.amount
			orderdetail.save
		end
		@cartitems.destroy_all
		redirect_to orders_thanks_path
	end

	def index
		@orders = current_customer.orders
	end

	def show
		@order = Order.find(params[:id])
	end

	private
	def order_params
		params.require(:order).permit(:postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
	end
end
