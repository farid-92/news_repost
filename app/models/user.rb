class User < ApplicationRecord
  validates :first_name, presence: true

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end
end
