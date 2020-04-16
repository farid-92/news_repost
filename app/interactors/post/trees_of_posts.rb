class Post::TreesOfPosts
  include Interactor

  def call
    posts = Post.where(repost_news_id: nil)

    result = []
    posts.each do |p|
      @count = 0
      count_of_children(p.subnews)
      result << {post_id: p.id, count_of_children: @count}
    end
    if result.present?
      context.resource = result
    else
      context.fail! errors: result.errors
    end
  end

  private

  def count_of_children(posts)
    posts.each do |post|
      @count += 1
      count_of_children(post.subnews)
    end
  end

end
