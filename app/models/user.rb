class User < ApplicationRecord
  validates :email, uniqueness: true
  validates :role, inclusion: { in: %w(registered admin) }

  before_validation :downcase_email
  after_initialize :default_role!

  private

  def downcase_email
    self.email = email.downcase
  end

  def default_role!
    self.role ||= 'registered'
  end
end
