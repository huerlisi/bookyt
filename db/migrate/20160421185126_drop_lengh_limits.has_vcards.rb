# This migration comes from has_vcards (originally 20141107181915)
class DropLenghLimits < ActiveRecord::Migration
  def change
    change_column :has_vcards_addresses, :post_office_box, :string, limit: nil
    change_column :has_vcards_addresses, :extended_address, :string, limit: nil
    change_column :has_vcards_addresses, :street_address, :string, limit: nil
    change_column :has_vcards_addresses, :locality, :string, limit: nil
    change_column :has_vcards_addresses, :region, :string, limit: nil
    change_column :has_vcards_addresses, :postal_code, :string, limit: nil
    change_column :has_vcards_addresses, :country_name, :string, limit: nil

    change_column :has_vcards_phone_numbers, :number, :string, limit: nil
    change_column :has_vcards_phone_numbers, :phone_number_type, :string, limit: nil

    change_column :has_vcards_vcards, :full_name, :string, limit: nil
    change_column :has_vcards_vcards, :nickname, :string, limit: nil
    change_column :has_vcards_vcards, :family_name, :string, limit: nil
    change_column :has_vcards_vcards, :given_name, :string, limit: nil
    change_column :has_vcards_vcards, :additional_name, :string, limit: nil
    change_column :has_vcards_vcards, :honorific_prefix, :string, limit: nil
    change_column :has_vcards_vcards, :honorific_suffix, :string, limit: nil
  end
end
