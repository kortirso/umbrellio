require 'httparty'

class RateCreateService
  include HTTParty

  base_uri 'http://localhost:3000/api/v1/rates.json'
  format :json

  def initialize; end

  def call(args = {})
    body = { rate: { post_id: args[:post_id], value: args[:value] } }
    self.class.post('', query: body, headers: {})
  end
end
