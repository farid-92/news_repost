describe 'POST create user', type: :request do

  before { post(admin_users_path, headers, params) }

  context 'without params' do
    let(:headers) { nil }
    let(:params) { nil }

    it { expect(response.status).to eq(422) }

    it 'should response errors' do
      expect(response_json[:errors]).to match_array([
                                                      {source: 'first_name', message: 'First name can\'t be blank'}
                                                    ])
    end
  end

  context 'with valid params' do
    let(:headers) { nil }
    let(:params) do
      {
        first_name: 'John',
        last_name: 'Doe'
      }
    end

    it { expect(response.status).to eq(201) }

    it 'should response new user' do
      id = User.last.id
      expect(response_json[:id]).to eq(id)
      expect(response_json[:first_name]).to eq('John')
      expect(response_json[:last_name]).to eq('Doe')
      expect(response_json[:full_name]).to eq('John Doe')
    end
  end

end
