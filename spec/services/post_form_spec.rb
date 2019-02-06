RSpec.describe PostForm, type: :service do
  describe '.persist?' do
    context 'for invalid data' do
      let(:service) { PostForm.new(user: nil, title: '1', content: '2', author_ip: '3') }

      it 'returns false' do
        expect(service.persist?).to eq false
      end
    end

    context 'for valid data' do
      let!(:user) { create :user }
      let!(:service) { PostForm.new(user: user, title: '1', content: '2', author_ip: '3') }

      it 'creates new post' do
        expect { service.persist? }.to change { user.posts.count }.by(1)
      end

      it 'and returns new post' do
        service.persist?

        expect(service.post).to eq Post.last
      end
    end
  end
end
