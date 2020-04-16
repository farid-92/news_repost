describe 'Post repost post', type: :request do

  let!(:user) { create :user, first_name: 'John', last_name: 'Doe'}
  let!(:post) { create :post, title: 'test', content: 'test', user_id: user.id}


  context 'repost first post' do
    before {get(repost_path(post.id), headers, params)}
    let(:headers) { nil }
    let(:params) { nil }

    it {expect(response.status).to eq(200)}

    it {expect(Post.count).to eq(2)}

    it 'should response message' do
      expect(response_json[:message]).to eq("Post with id #{post.id} was reposted")
    end

  end
end
