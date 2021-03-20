class Public::CartItemsController < ApplicationController
	def index
		@cartitems = current_customer.cart_items
		@price = 0
		@cartitems.each do |cartitem|
			@price += (cartitem.item.price * 1.1 * cartitem.amount).ceil
		end
	end

	def update
		cartitem = CartItem.find(params[:id])
		cartitem.update(cartitem_params)
		redirect_to cart_items_path
	end

	def destroy
		cartitem = CartItem.find(params[:id])
		cartitem.destroy
		redirect_to cart_items_path
	end

	def destroy_all
		cartitems = current_customer.cart_items
		cartitems.destroy_all
		redirect_to cart_items_path
	end

	def create
		@cartitem = CartItem.new(cartitem_params)
		@cartitem.customer_id = current_customer.id
		cartitems = current_customer.cart_items

		cartitems.each do |cartitem|
			if cartitem.item_id == @cartitem.item_id # もし同じ商品があれば
				new_amount = cartitem.amount + @cartitem.amount # 個数を足してnew_amountに入れる。
				cartitem.update_attribute(:amount, new_amount) # :amountにnewamountを登録する。
				@cartitem.delete # 新規追加用のnewは不要のため削除
				redirect_to cart_items_path and return # ここで処理を終わらせている。

			end
		end
		@cartitem.save
		redirect_to cart_items_path
	end

	private
	def cartitem_params
		params.require(:cart_item).permit(:amount, :item_id)
	end
end