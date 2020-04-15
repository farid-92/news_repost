describe 'POST create post', type: :request do
  let!(:user) { create :user, first_name: 'John', last_name: 'Doe'}

  before { post(admin_posts_path, headers, params) }

  context 'without params' do
    let(:headers) { nil }
    let(:params) { nil }

    it { expect(response.status).to eq(422) }

    it 'should response errors' do
      expect(response_json[:errors]).to match_array([
                                                      {source: 'title', message: 'Title can\'t be blank'},
                                                      {source: 'user', message: 'User must exist'}
                                                    ])
    end
  end

  context 'with valid params' do
    let(:headers) { nil }
    let(:params) do
      {
        title: 'test',
        content: 'here will be content',
        user_id: user.id
      }
    end

    it { expect(response.status).to eq(201) }

    it 'should response new post' do
      id = Post.last.id
      expect(response_json[:id]).to eq(id)
      expect(response_json[:title]).to eq('test')
      expect(response_json[:content]).to eq('here will be content')
      expect(response_json[:author]).to eq('John Doe')
    end
  end

end
