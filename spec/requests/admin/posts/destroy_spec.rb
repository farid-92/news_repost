describe 'DELETE destroy post', type: :request do

  let!(:user) { create :user, first_name: 'John', last_name: 'Doe'}
  let!(:post) { create :post, title: 'test', content: 'test content', user_id: user.id}

  context 'when post not exist' do
    let(:headers) { nil }
    let(:params) { nil }
    id = 0
    before { delete(admin_post_path(id), headers, params) }

    it { expect(response.status).to eq(404) }

    it {
      expect(response_json[:message]).to eq("Couldn't find Post with 'id'=#{id}")
    }
  end

  context 'with valid params' do
    let(:headers) { nil }
    let(:params) { nil }
    before { delete(admin_post_path(post.id),headers , params) }

    it { expect(response.status).to eq(200) }
    it { expect(Post.count).to eq(0) }
    it {
      expect(response_json[:message]).to eq("Post deleted")
    }
  end
end
