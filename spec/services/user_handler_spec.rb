RSpec.describe UserHandler, type: :service do
  let!(:user) { create :user }
  let!(:service) { UserHandler.new(username: user.username) }
  let!(:invalid_service) { UserHandler.new(username: '') }

  describe '.initialize' do
    it 'assigns username to @username' do
      expect(service.username).to eq user.username
    end
  end

  describe '.valid?' do
    context 'for invalid data' do
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
    context 'for invalid data' do
      it 'returns nil' do
        expect(invalid_service.call).to eq nil
      end
    end

    context 'for valid data' do
      it 'returns nil' do
        result = service.call

        expect(result).to eq user
      end
    end
  end
end
