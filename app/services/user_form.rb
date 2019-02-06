class UserForm
  include ActiveModel::Model
  include Virtus.model

  attribute :username, String

  validates :username, presence: true

  def persist
    return nil unless valid?
    user = User.find_by_username(username)
    user.nil? ? User.create(username: username) : user
  end
end
