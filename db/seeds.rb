service = PostCreateService.new

10.times do |user_index|
  username = "user_#{user_index}"
  ip = "192.168.0.#{rand(30)}"
  2000.times do |post_index|
    service.call({title: "Title #{post_index}", content: "Some content for post_#{post_index}", author_ip: ip, username: username})
  end
  puts "User #{user_index} and his 2000 posts are created"
end
