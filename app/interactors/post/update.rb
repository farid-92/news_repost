class Post::Update
  include Interactor

  def call
    params = context.params
    post = context.post
    if post.update(params)
      context.resource = post
    else
      context.fail! errors: post.errors
    end
  end
end
