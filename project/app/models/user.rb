class User < ApplicationRecord

  has_secure_password

  before_validation :downcase_email

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates_presence_of :password_digest

  private

  def downcase_email
    self.email = email.downcase if email.present?
  end

end
