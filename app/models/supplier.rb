# == Schema Information
#
# Table name: suppliers
#
#  id   :integer          not null, primary key
#  name :string
#  code :integer
#

class Supplier < ApplicationRecord
  with_options presence: true do
    validates :code
    validates :name
  end
end
