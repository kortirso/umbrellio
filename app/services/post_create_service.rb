require 'httparty'

class PostCreateService
  include HTTParty

  base_uri 'http://localhost:3000/api/v1/posts.json'
  format :json

  def initialize; end

  def call(args = {})
    body = { post: { title: args[:title], content: args[:content], author_ip: args[:author_ip], username: args[:username] } }
    self.class.post('', query: body, headers: {})
  end
end
