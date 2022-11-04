class User < ApplicationRecord
  before_destroy :must_not_destroy_last_one_admin
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, uniqueness: true, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, length: { minimum: 6 }
  has_many :tasks, dependent: :destroy



  private

  def must_not_destroy_last_one_admin
    if User.find(id).admin
    throw(:abort) if (User.where(admin:true).count - [self].count == 0)
  end
end
end
