class Admin::PostsController < ApplicationController

  before_action :fetch_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all.includes(:user)
    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def new
    @post = Post.new
  end

  def show; end

  def create
    result = Post::Create.call(params: post_params)

    if result.errors.blank?
      respond_to do |format|
        format.html { redirect_to admin_posts_path }
        format.json { render json: result.resource, serializer: PostSerializer, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: ErrorsSerializer.serialize(result.errors), status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    result = Post::Update.call(params: post_params, post: @post)

    if result.errors.blank?
      respond_to do |format|
        format.html { redirect_to admin_posts_path }
        format.json { render json: result.resource, serializer: PostSerializer, status: :ok }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: ErrorsSerializer.serialize(result.errors), status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to admin_posts_path }
      format.json { render json: {message: "Post deleted"} }
    end
  end

  private

  def post_params
    params.permit(:title, :content, :user_id)
  end

  def fetch_post
    @post = Post.find(params[:id])
  rescue => e
    render json: { message:  e}, status: :not_found
  end



end
