# == Schema Information
#
# Table name: products
#
#  id                 :integer          not null, primary key
#  sku                :integer
#  supplier_code      :integer
#  name               :string
#  additional_field_1 :text
#  additional_field_2 :text
#  additional_field_3 :text
#  additional_field_4 :text
#  additional_field_5 :text
#  price              :decimal(5, 2)    default(0.0)
#

class Product < ApplicationRecord
  paginates_per 50

  with_options presence: true do
    validates :price
    validates :sku
    validates :name
    validates :supplier_code
  end

  belongs_to :supplier, foreign_key: :supplier_code, primary_key: :code, optional: true
end
