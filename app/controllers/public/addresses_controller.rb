class Public::AddressesController < ApplicationController
	before_action :authenticate_customer!
	def index
		@address = Address.new
		@addresses = current_customer.addresses
	end

	def create
		@address = Address.new(address_params)
		@address.customer_id = current_customer.id
		unless @address.save
			@addresses = current_customer.addresses
			render :index and return
		end
		redirect_to addresses_path
	end

	def destroy
		@address = Address.find(params[:id])
		@address.destroy
		redirect_to addresses_path
	end

	private
	def address_params
		params.require(:address).permit(:name, :postal_code, :address)
	end
end
