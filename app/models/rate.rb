# Represents rates for posts
class Rate < ApplicationRecord
  belongs_to :post
end
