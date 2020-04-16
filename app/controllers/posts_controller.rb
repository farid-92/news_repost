class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def repost
    result = Post::Repost.call(params: params)

    if result.errors.blank?
      render json: {message: "Post with id #{params[:id]} was reposted"}
    else
      render json: ErrorsSerializer.serialize(result.errors), status: :unprocessable_entity
    end
  end

  def count_repost_of_initial_post
    result = Post::TreesOfPosts.call

    if result.errors.blank?
      render json: {initial_posts_with_repost_count: result.resource }
    else
      render json: ErrorsSerializer.serialize(result.errors), status: :unprocessable_entity
    end

  end


end
