RSpec.describe 'Rates API' do
  describe 'POST #create' do
    context 'for unexisted post' do
      let(:request) { post '/api/v1/rates.json', params: { post_id: nil, rate: { value: 1 } } }

      it 'does not create rate' do
        expect { request }.to_not change(Rate, :count)
      end

      context 'in response' do
        before { request }

        it 'returns status 404' do
          expect(response.status).to eq 404
        end

        it 'and contains error message' do
          expect(JSON.parse(response.body)['errors']).to eq ['Post is not found']
        end
      end
    end

    context 'for existed post' do
      let!(:object) { create :post }

      context 'for invalid params' do
        let(:request) { post '/api/v1/rates.json', params: { post_id: object.id, rate: { value: 11 } } }

        it 'does not create rate' do
          expect { request }.to_not change(Rate, :count)
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
        let(:request) { post '/api/v1/rates.json', params: { post_id: object.id, rate: { value: 1 } } }

        it 'creates rate' do
          expect { request }.to change { object.rates.count }.by(1)
        end

        context 'in response' do
          before { request }

          it 'returns status 200' do
            expect(response.status).to eq 200
          end

          it 'and contains post post_average_rate' do
            expect(response.body).to have_json_path('post_average_rate')
          end
        end
      end
    end
  end
end
