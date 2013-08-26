class BankSerializer < ActiveModel::Serializer
  attributes :id
  attributes :clearing, :swift
end
