RSpec.describe UserForm, type: :service do
  let!(:user) { create :user }

  describe '.persist' do
    context 'for invalid data' do
      let(:service) { UserForm.new(username: '') }

      it 'returns nil' do
        expect(service.persist).to eq nil
      end
    end

    context 'for valid data' do
      context 'for existed user' do
        let(:service) { UserForm.new(username: user.username) }

        it 'returns existed user' do
          expect(service.persist).to eq user
        end
      end

      context 'for unexisted user' do
        let!(:service) { UserForm.new(username: 'Coolio') }

        it 'creates new user' do
          expect { service.persist }.to change { User.count }.by(1)
        end

        it 'and returns new user' do
          expect(service.persist).to eq User.last
        end
      end
    end
  end
end
