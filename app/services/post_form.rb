class PostForm
  include ActiveModel::Model
  include Virtus.model

  attribute :user, User
  attribute :title, String
  attribute :content, String
  attribute :author_ip, String

  validates :user, :title, :content, :author_ip, presence: true

  attr_reader :post

  def persist?
    if valid?
      @post = Post.new
      @post.attributes = attributes
      @post.save
      true
    else
      false
    end
  end
end
