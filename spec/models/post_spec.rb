RSpec.describe Post, type: :model do
  it { should belong_to :user }
  it { should have_many(:rates).dependent(:destroy) }

  it 'factory should be valid' do
    post = create :post

    expect(post).to be_valid
  end
end
