describe 'PUT update user', type: :request do
  let!(:user) { create :user, first_name: 'John', last_name: 'Doe'}


  context 'when post not exist' do
    let(:headers) { nil }
    let(:params) { nil }
    id = 0
    before { put(admin_user_path(id), headers, params) }

    it { expect(response.status).to eq(404) }

    it {
      expect(response_json[:message]).to eq("Couldn't find User with 'id'=#{id}")
    }
  end

  context 'with invalid params' do
    let(:headers) { nil }
    let(:params) do
      {
        first_name: '',
        last_name: 'Doe'
      }
    end

    before { put(admin_user_path(user.id), headers, params) }

    it { expect(response.status).to eq(422) }

    it 'should response errors' do
      expect(response_json[:errors]).to match_array([
                                                      {source: 'first_name', message: 'First name can\'t be blank'}
                                                    ])
    end
  end

  context 'without params' do
    let(:headers) { nil }
    let(:params) { nil }
    before { put(admin_user_path(user.id), headers, params) }

    it { expect(response.status).to eq(200) }

    it 'should not update user' do
      user.reload
      expect(user.first_name).to eq('John')
      expect(user.last_name).to eq('Doe')
      expect(user.full_name).to eq('John Doe')
    end
  end

  context 'with valid params' do
    let(:headers) { nil }
    let(:params) do
      {
        first_name: 'Ivan',
        last_name: 'Ivanov',
      }
    end

    before { put(admin_user_path(user.id), headers, params) }

    it { expect(response.status).to eq(200) }

    it 'should update user' do
      user.reload
      expect(user.first_name).to eq('Ivan')
      expect(user.last_name).to eq('Ivanov')
      expect(user.full_name).to eq('Ivan Ivanov')
    end
  end
end
