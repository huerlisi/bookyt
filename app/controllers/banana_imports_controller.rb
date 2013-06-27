class BananaImportsController < ApplicationController
	def new
	end

	def create
		xml = Nokogiri.XML(params[:upload][:file])

		@banana_accounts_import = Banana::Account.import(xml)
		@banana_bookings_import = Banana::Booking.import(xml)

		redirect_to new_banana_import_path, notice: 'Banana Import successful.'
	end
end
