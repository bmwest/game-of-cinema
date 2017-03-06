class Theater < ApplicationRecord
  validates :name, presence:true
  validates :address, presence:true
  validates :city, presence:true
  validates :state, presence:true
  validates :zip, presence:true, numericality: { only_integer:true }, length: { is: 5 }
end
