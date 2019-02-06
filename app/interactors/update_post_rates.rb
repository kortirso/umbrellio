# Update rates for post
class UpdatePostRates
  include Interactor

  # required context
  # context.post
  # context.value
  def call
    post = context.post

    post.total_rate += context.value
    post.rates_count += 1
    post.average_rate = post.rates_count.zero? ? 0 : post.total_rate * 100 / post.rates_count
    post.save

    context.average_rate = post.average_rate
  end
end
