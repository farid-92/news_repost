describe 'GET index post', type: :request do

  let!(:user) { create :user, first_name: 'John', last_name: 'Doe'}
  let!(:post1) { create :post, title: 'test', content: 'test', user_id: user.id}
  let!(:post2) { create :post, title: 'test 2', content: 'test content', user_id: user.id}

  before {get(admin_posts_path, headers, nil)}

  context 'list posts page' do
    it {expect(response.status).to eq(200)}

    it {expect(Post.count).to eq(2)}

    it 'should response titles' do
      expect(response_json.map {|s| s["title"]}).to eq(['test', 'test 2'])
    end

    it 'should response contents' do
      expect(response_json.map {|s| s["content"]}).to eq(['test', 'test content'])
    end
  end
end
