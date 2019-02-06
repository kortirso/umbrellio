RSpec.describe RateForm, type: :service do
  describe '.persist?' do
    context 'for invalid data' do
      let(:service) { RateForm.new(post: nil, value: 1) }

      it 'returns false' do
        expect(service.persist?).to eq false
      end
    end

    context 'for valid data' do
      let!(:post) { create :post }
      let!(:service) { RateForm.new(post: post, value: 2) }

      it 'creates new rate' do
        expect { service.persist? }.to change { post.rates.count }.by(1)
      end

      it 'and returns new rate' do
        service.persist?

        expect(service.rate).to eq Rate.last
      end
    end
  end
end
