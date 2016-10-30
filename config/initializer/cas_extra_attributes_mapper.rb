class CASExtraAttributesMapper
  def self.call(extra_attributes, user)
    extra_attributes.each do |name, value|
      case name.to_sym
      when :tenant
        # .find_by not works in Rails 3
        admin_tenant = Admin::Tenant.where(db_name: value).first
        user.tenant = ::Tenant.where(id: admin_tenant.try(:id)).first
      when :roles
        user.role_texts = [value.split(',')].flatten
      end
    end
  end
end
