describe 'Post repost post', type: :request do

  let!(:user) { create :user, first_name: 'John', last_name: 'Doe'}
  let!(:post) { create :post, title: 'test', content: 'test content', user_id: user.id}
  let!(:post2) { create :post, title: 'post 1', content: 'post content 1', user_id: user.id, repost_news_id: post.id}
  let!(:post3) { create :post, title: 'post 2', content: 'post content 2', user_id: user.id, repost_news_id: post2.id}
  let!(:post4) { create :post, title: 'post 3', content: 'post content 3', user_id: user.id, repost_news_id: post2.id}


  context 'count repost of initial post' do
    before {get(count_repost_of_initial_post_path, headers, params)}
    let(:headers) { nil }
    let(:params) { nil }

    it {expect(response.status).to eq(200)}

    # данный тест иногда падает потому, что возвращает разные id,
    # пока не знаю с чем это связано. Есть предположение,
    # что база не успевает сбрасывать id и при запуске теста id продолжается, а не начинается с 1
    it 'should response post id equal 1 ' do
      expect(response_json[:initial_posts_with_repost_count].map {|s| s["post_id"]}).to eq([1])
    end

    it 'should response repost count of post with id 1' do
      expect(response_json[:initial_posts_with_repost_count].map {|s| s["count_of_children"]}).to eq([3])
    end

  end
end
