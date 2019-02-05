RSpec.describe 'Posts API' do
  describe 'POST #create' do
    context 'for invalid params' do
      let(:request) { post '/api/v1/posts.json', params: { post: { title: '', content: '', author_ip: '' }, user: { username: '' } } }

      it 'does not create post' do
        expect { request }.to_not change(Post, :count)
      end

      it 'does not create user' do
        expect { request }.to_not change(User, :count)
      end

      context 'in response' do
        before { request }

        it 'returns status 422' do
          expect(response.status).to eq 422
        end

        it 'and contains error message' do
          expect(JSON.parse(response.body)['errors']).to_not eq nil
        end
      end
    end

    context 'for invalid post params' do
      let(:request) { post '/api/v1/posts.json', params: { post: { title: '', content: '', author_ip: '' }, user: { username: 'something' } } }

      it 'does not create post' do
        expect { request }.to_not change(Post, :count)
      end

      it 'and creates user' do
        expect { request }.to change { User.count }.by(1)
      end

      context 'in response' do
        before { request }

        it 'returns status 422' do
          expect(response.status).to eq 422
        end

        it 'and contains error message' do
          expect(JSON.parse(response.body)['errors']).to_not eq nil
        end
      end
    end

    context 'for valid params' do
      let(:request) { post '/api/v1/posts.json', params: { post: { title: '1', content: '2', author_ip: '3' }, user: { username: 'something' } } }

      it 'creates post' do
        expect { request }.to change { Post.count }.by(1)
      end

      it 'and creates user' do
        expect { request }.to change { User.count }.by(1)
      end

      context 'in response' do
        before { request }

        it 'returns status 201' do
          expect(response.status).to eq 201
        end

        %w[id title content author_ip].each do |attr|
          it "and contains post #{attr}" do
            expect(response.body).to have_json_path(attr)
          end
        end
      end
    end
  end
end
