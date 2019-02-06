post_service = PostCreateService.new
rate_service = RateCreateService.new

20.times do |user_index|
  username = "user_#{user_index}"
  ip = "192.168.0.#{rand(1..3)}"
  2000.times do |post_index|
    post_service.call(title: "Title #{post_index}", content: "Some content for post_#{post_index}", author_ip: ip, username: username)
    next unless (post_index % 3).zero?
    post_id = Post.last.id
    rand(5..10).times { rate_service.call(post_id: post_id, value: rand(1..5)) }
  end
  puts "User #{user_index} and his 2000 posts are created"
end
