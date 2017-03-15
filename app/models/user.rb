class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence:true
  validates :last_name, presence:true

  has_many :theaters
  has_many :reviews
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable


  def admin?
    role == "admin"
  end

  def self.search(search)
    where("first_name LIKE ? OR last_name LIKE ?", "%#{search}%", "%#{search}%")
  end
end
