class Post::Create
  include Interactor

  def call
    params = context.params
    post = Post.create(params)
    if post.valid?
      context.resource = post
    else
      context.fail! errors: post.errors
    end
  end
end
