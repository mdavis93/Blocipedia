class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wikis, dependent: :destroy

  # validates :email, presence: true
  # validates :password, presence: true

  after_initialize { self.role ||= :standard }

  enum role: [:standard, :premium, :admin]
end
