describe 'DELETE destroy user', type: :request do

  let!(:user) { create :user, first_name: 'John', last_name: 'Doe'}

  context 'when user not exist' do
    let(:headers) { nil }
    let(:params) { nil }
    id = 0
    before { delete(admin_user_path(id), headers, params) }

    it { expect(response.status).to eq(404) }

    it {
      expect(response_json[:message]).to eq("Couldn't find User with 'id'=#{id}")
    }
  end

  context 'with valid params' do
    let(:headers) { nil }
    let(:params) { nil }
    before { delete(admin_user_path(user.id),headers , params) }

    it { expect(response.status).to eq(200) }
    it { expect(User.count).to eq(0) }
    it {
      expect(response_json[:message]).to eq("User deleted")
    }
  end
end
