# Represents posts of users
class Post < ApplicationRecord
  belongs_to :user

  has_many :rates, dependent: :destroy

  def self.ips_with_users
    Post
      .joins(:user)
      .where('posts.user_id IN (?)', User.pluck(:id))
      .group('posts.author_ip')
      .group('users.username')
      .order('posts.author_ip, users.username')
      .pluck('posts.author_ip', 'users.username')
  end
end
