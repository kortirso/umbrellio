RSpec.describe User, type: :model do
  it { should have_many(:posts).dependent(:destroy) }
  it { should validate_uniqueness_of(:username) }

  it 'factory should be valid' do
    user = create :user

    expect(user).to be_valid
  end

  describe '.create_or_find_by' do
    let!(:user) { create :user }

    context 'for unexisted user' do
      it 'creates user' do
        expect { User.create_or_find_by(username: 'Coolio') }.to change { User.count }.by(1)
      end
    end

    context 'for existed user' do
      let!(:request) { User.create_or_find_by(username: user.username) }

      it 'does not create user' do
        expect { request }.to_not change(User, :count)
      end

      it 'and returns existed user' do
        expect(request).to eq user
      end
    end
  end
end
