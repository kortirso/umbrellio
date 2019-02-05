RSpec.describe PostHandler, type: :service do
  let!(:title) { 'Title' }
  let!(:content) { 'Content' }
  let!(:author_ip) { '192.168.0.1' }
  let!(:user) { create :user }
  let!(:service) { PostHandler.new({ title: title, content: content, author_ip: author_ip }, username: user.username) }

  describe '.initialize' do
    it 'assigns title to @title' do
      expect(service.title).to eq title
    end

    it 'assigns content to @content' do
      expect(service.content).to eq content
    end

    it 'assigns author_ip to @author_ip' do
      expect(service.author_ip).to eq author_ip
    end

    it 'assigns user to @user' do
      expect(service.user).to eq user
    end
  end

  describe '.valid?' do
    context 'for invalid data' do
      let!(:invalid_service) { PostHandler.new({ title: '', content: content, author_ip: author_ip }, username: '') }

      it 'returns false' do
        expect(invalid_service.valid?).to eq false
      end
    end

    context 'for valid data' do
      it 'returns true' do
        expect(service.valid?).to eq true
      end
    end
  end

  describe '.call' do
    it 'returns created post' do
      result = service.call

      expect(result.is_a?(Post)).to eq true
    end
  end
end
