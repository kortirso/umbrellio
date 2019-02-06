class PostHandler
  include ActiveModel::Validations

  attr_reader :user, :title, :content, :author_ip

  validates :user, :title, :content, :author_ip, presence: true

  def initialize(post_params = {}, user_params = {})
    @user = UserHandler.call(user_params)
    @title = post_params[:title]
    @content = post_params[:content]
    @author_ip = post_params[:author_ip]
  end

  def call
    Post.create(user: user, title: title, content: content, author_ip: author_ip)
  end
end
