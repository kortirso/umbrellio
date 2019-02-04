RSpec.describe Rate, type: :model do
  it { should belong_to :post }

  it 'factory should be valid' do
    rate = create :rate

    expect(rate).to be_valid
  end
end
