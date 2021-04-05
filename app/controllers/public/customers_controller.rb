class Public::CustomersController < ApplicationController
	before_action :authenticate_customer!
	def show
	end

	def edit
	end

	def update
		current_customer.update(customer_params)
		redirect_to customer_path
	end

	def unsubscribe
	end

	def withdraw
		@customer = current_customer
		@customer.update(is_active: false)
		reset_session
		redirect_to new_customer_registration_path
	end

	private
	def customer_params
		params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number)
	end
end
