class User < ApplicationRecord

  mount_uploader :avatar, AvatarUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence:true
  validates :last_name, presence:true

  has_many :theaters
  has_many :reviews
  has_many :votes
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable


  def admin?
    role == "admin"
  end
end
