# Represents posts of users
class Post < ApplicationRecord
  belongs_to :user

  has_many :rates, dependent: :destroy
end
