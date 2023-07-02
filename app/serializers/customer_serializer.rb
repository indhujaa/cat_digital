# frozen_string_literal: true

class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :email,
             :mobile_no, :city, :country, :state,
             :dob, :height, :created_at
end
