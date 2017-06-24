class BlogPostsController < ApplicationController
  before_action :set_blog_post, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    @blog_posts = BlogPost.all
    # respond_with(@blog_posts)
  end

  def show
    render "show", locals: { blog: @blog_post }
  end

  def new
    verify_user!
    @blog_post = BlogPost.new
    respond_with(@blog_post)
  end

  def edit
    verify_user!
  end

  def create
    verify_user!
    @blog_post = BlogPost.new(blog_post_params)
    @blog_post.save
    respond_with(@blog_post)
  end

  def update
    verify_user!
    @blog_post.update(blog_post_params)
    respond_with(@blog_post)
  end

  def destroy
    verify_user!
    @blog_post.destroy
    respond_with(@blog_post)
  end

  private
    def set_blog_post
      @blog_post = BlogPost.find(params[:id])
    end

    def verify_user!
      head :unauthorized unless current_user.try(:id).try(:to_s) == ENV["AUTHORIZED_BLOG_EDITOR_IDS"]
    end

    def blog_post_params
      params.require(:blog_post).permit(:title, :body, :author)
    end
end
