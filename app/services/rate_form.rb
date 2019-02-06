class RateForm
  include ActiveModel::Model
  include Virtus.model

  attribute :post, Post
  attribute :value, Integer

  validates :post, :value, presence: true
  validates :value, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

  attr_reader :rate

  def persist?
    if valid?
      @rate = Rate.new
      @rate.attributes = attributes
      @rate.save
      true
    else
      false
    end
  end
end
