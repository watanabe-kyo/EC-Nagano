class Admin::HomesController < ApplicationController
	require 'date'
	def top
		@count = Order.where("created_at >= ?", Date.today).count

	end
end
