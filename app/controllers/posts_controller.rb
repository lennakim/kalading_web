class PostsController < ApplicationController

  before_action :set_tag_and_menu

  layout "new"

  inherit_resources

  # def show
  #   @post = Post.find_by slug: params[:slug]
  #   show!
  # end

  def show
    @posts = Post.where slug: params[:slug]
  end

  def posts_list
    @posts = Post.tagged_with(@tag)

    #@first_posts = Post.all.map{|p| p.tags.first }.uniq

    render "show"
  end

  def set_tag_and_menu
    @tag = ActsAsTaggableOn::Tag.find params[:tag_id]
    @title = @tag.name
    @root_tag = Post.tagged_with(@title).first.tag_list.first
    @tag_list = Post.tagged_with(@root_tag).map(&:tag_list).map{|e| e[1]}.uniq.map{ |name| ActsAsTaggableOn::Tag.find_by name: name }
  end

end
