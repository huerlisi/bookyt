class BananaImportsController < ApplicationController
	def create		
		file = params[:banana_import].try(:file)
		
		if file.present?
		  xml = Nokogiri.XML(file)
		  @banana_accounts_import = Banana::Account.import(xml)
		  @banana_bookings_import = Banana::Booking.import(xml)

		  redirect_to new_banana_import_path, notice: t('banana_import.flash.success')
		else
		  flash[:alert] = t('banana_import.flash.file_missing')
		  render 'new'
		end
	end
end
