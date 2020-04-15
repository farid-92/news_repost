describe 'PUT update post', type: :request do
  let!(:user) { create :user, first_name: 'John', last_name: 'Doe'}
  let!(:post) { create :post, title: 'test', content: 'test content', user_id: user.id}


  context 'when post not exist' do
    let(:headers) { nil }
    let(:params) { nil }
    id = 0
    before { put(admin_post_path(id), headers, params) }

    it { expect(response.status).to eq(404) }

    it {
      expect(response_json[:message]).to eq("Couldn't find Post with 'id'=#{id}")
    }
  end

  context 'with invalid params' do
    let(:headers) { nil }
    let(:params) do
      {
        title: '',
        content: 'here will be content',
        user_id: user.id
      }
    end

    before { put(admin_post_path(post.id), headers, params) }

    it { expect(response.status).to eq(422) }

    it 'should response errors' do
      expect(response_json[:errors]).to match_array([
                                                      {source: 'title', message: 'Title can\'t be blank'}
                                                    ])
    end
  end

  context 'without params' do
    let(:headers) { nil }
    let(:params) { nil }
    before { put(admin_post_path(post.id), headers, params) }

    it { expect(response.status).to eq(200) }

    it 'should not update post' do
      post.reload
      expect(post.title).to eq('test')
      expect(post.content).to eq('test content')
    end
  end

  context 'with valid params' do
    let(:headers) { nil }
    let(:params) do
      {
        title: 'new title',
        content: 'here will new be content',
      }
    end

    before { put(admin_post_path(post.id), headers, params) }

    it { expect(response.status).to eq(200) }

    it 'should update post' do
      post.reload
      expect(post.title).to eq('new title')
      expect(post.content).to eq('here will new be content')
    end
  end
end
