class RateHandler
  include ActiveModel::Validations

  attr_reader :post, :value

  validates :post, :value, presence: true
  validates :value, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

  def initialize(rate_params)
    @post = Post.find_by_id(rate_params[:post_id])
    @value = rate_params[:value].to_i
  end

  def call
    Rate.create(post: post, value: value)
    UpdatePostRates.call(post: post, value: value)
  end
end
