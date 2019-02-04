RSpec.describe User, type: :model do
  it { should have_many(:posts).dependent(:destroy) }

  it 'factory should be valid' do
    user = create :user

    expect(user).to be_valid
  end
end
