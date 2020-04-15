describe 'GET index user', type: :request do

  let!(:user) { create :user, first_name: 'John', last_name: 'Doe'}
  let!(:user1) { create :user, first_name: 'Jane', last_name: 'Doe'}

  before {get(admin_users_path, headers, nil)}

  context 'list users page' do
    it {expect(response.status).to eq(200)}

    it {expect(User.count).to eq(2)}

    it 'should response first names' do
      expect(response_json.map {|s| s["first_name"]}).to eq(['John', 'Jane'])
    end

    it 'should response last names' do
      expect(response_json.map {|s| s["last_name"]}).to eq(['Doe', 'Doe'])
    end

    it 'should response full names' do
      expect(response_json.map {|s| s["full_name"]}).to eq(['John Doe', 'Jane Doe'])
    end
  end
end
