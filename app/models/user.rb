# Represents users
class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  validates :username, uniqueness: true

  def self.create_or_find_by(args = {})
    create!(args)
  rescue ActiveRecord::RecordInvalid
    find_by(args)
  end
end
