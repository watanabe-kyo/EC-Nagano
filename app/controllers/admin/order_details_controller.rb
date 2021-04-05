class Admin::OrderDetailsController < ApplicationController
	def update
		orderdetail = OrderDetail.find(params[:id])
		orderdetail.update(order_detail_params)
		if orderdetail.making_status == "製作中"
			orderdetail.order.update(status: "製作中")
		end
		order = Order.find_by(id: params[:order_id])
		# p "aaaa"
		count = order.order_details.where.not(making_status: "製作完了").count
		# p "aaaaaaaaa"
		if count == 0
			order.update(status: "発送準備中")
		end
		redirect_to request.referer
	end

	private
	def order_detail_params
		params.require(:order_detail).permit(:making_status)
	end
end
