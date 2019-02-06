class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :author_ip, :average_rate

  def average_rate
    object.average_rate / 100.0
  end
end
