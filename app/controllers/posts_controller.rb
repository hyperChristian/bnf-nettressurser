class PostsController < ApplicationController
  def index
    if params[:tag]
      @posts = Post.filter_by_tags(params[:tag]).page(params[:page]).per(Setting.post_per_page)
     # @mytags = "tags!!!"
    elsif

      params[:search].present?
      @posts = Post.matching_title_or_content(params[:search]).page params[:page]    
     # @posts = Post.published.page(params[:page]).per(Setting.post_per_page)
   # @mytags = "search!!!"
    else
     # @posts = Post.all.order(created_at: :desc).page params[:page]
      @posts = Post.all.where(:publish => true).order(:id => :asc, ancestry: :desc)
   # @mytags = "index!!!"
    end    
    @categories = Category.all
  end

  def show
    @post = Post.find(params[:id])
    render :layout => 'show_page'
  end
end