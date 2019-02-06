describe UpdatePostRates do
  let!(:object) { create :post }
  let!(:value) { 3 }

  describe '.call' do
    subject(:interactor) { UpdatePostRates.call(post: object, value: value) }

    it 'succeeds' do
      expect(interactor).to be_a_success
    end

    it 'and updates post total_rate' do
      expect { interactor }.to change { object.total_rate }.by(value)
    end

    it 'and updates post rates_count' do
      expect { interactor }.to change { object.rates_count }.by(1)
    end

    it 'and updates post average_rate' do
      expect { interactor }.to change { object.average_rate }.by(value * 100)
    end

    it 'and provides the average_rate' do
      expect(interactor.average_rate).to_not eq 0
    end
  end
end
