class AccountSerializer < ActiveModel::Serializer
  attributes :id, :type
  attributes :title, :account_type_id, :number, :code
end
