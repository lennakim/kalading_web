class PostsController < ApplicationController
  inherit_resources

  def about_us
    @posts = Post.tagged_with("关于我们")
    if id = params[:id]
      @post = Post.find params[:id]
    else
      @post = @posts.first
    end
  end

  def knowledge
    @posts = Post.tagged_with("用车知识")
    if id = params[:id]
      @post = Post.find params[:id]
    else
      @post = @posts.first
    end
  end
end
