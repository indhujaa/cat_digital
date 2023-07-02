# frozen_string_literal: true

class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email, index: { unique: true }
      t.string :mobile_no, index: { unique: true }
      t.date :dob
      t.float :height
      t.string :city
      t.string :state
      t.string :country

      t.timestamps
    end
  end
end
