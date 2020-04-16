class Post::Repost
  include Interactor

  def call
    params = context.params
    post = Post.find(params[:id])
    new_post = post.dup
    new_post.update(repost_news_id: post.id)
    new_post.save

    if new_post.valid?
      context.resource = new_post
    else
      context.fail! errors: new_post.errors
    end

  end
end
