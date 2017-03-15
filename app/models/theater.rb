class Theater < ApplicationRecord
  validates :name, presence:true
  validates :address, presence:true
  validates :city, presence:true
  validates :state, presence:true
  validates :zip, presence:true, numericality: { only_integer:true }, length: { is: 5 }

  belongs_to :user
  has_many :reviews
  mount_uploader :image, ImageUploader

  def self.search(search)
    where("name LIKE ? OR state LIKE ? OR city LIKE ? OR zip LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
  end
end
