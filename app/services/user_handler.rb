class UserHandler
  include ActiveModel::Validations

  attr_reader :username

  validates :username, presence: true

  def self.call(user_params)
    new(user_params).call
  end

  def initialize(user_params)
    @username = user_params[:username]
  end

  def call
    return User.create_or_find_by(username: username) if valid?
    nil
  end
end
