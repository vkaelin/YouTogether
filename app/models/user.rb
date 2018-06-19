class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true
  validates :name, :presence => true
  validates :role, inclusion: { in: %w(registered admin) }

  before_validation :downcase_email
  after_initialize :default_role!

  mount_uploader :avatar, AvatarUploader

  private

  def downcase_email
    self.email = email.downcase
  end

  def default_role!
    self.role ||= 'registered'
  end
end
