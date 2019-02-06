RSpec.describe RateHandler, type: :service do
  let!(:object) { create :post }
  let!(:service) { RateHandler.new(post_id: object.id, value: 2) }
  let!(:invalid_service) { RateHandler.new(post_id: nil, value: 3) }

  describe '.initialize' do
    context 'for invalid service' do
      it 'assigns nil to @post' do
        expect(invalid_service.post).to eq nil
      end
    end

    it 'assigns post to @post' do
      expect(service.post).to eq object
    end

    it 'assigns value to @value' do
      expect(service.value).to eq 2
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
    it 'creates rate' do
      expect { service.call }.to change { object.rates.count }.by(1)
    end

    it 'and calls UpdatePostRates' do
      expect(UpdatePostRates).to receive(:call)

      service.call
    end
  end
end
