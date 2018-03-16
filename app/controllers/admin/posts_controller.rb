class Admin::PostsController < Admin::ApplicationController

  def index
    if params[:search].present?
      @posts = Post.matching_title_or_content(params[:search])
    else
     #@posts = Post.scoped
      #@post = Post.new
      #@posts = Post.all.page params[:page]
       @posts = Post.all
    end
  end

  def new
    @posts = Post.all
    #@post = Post.new
    @post = Post.new(:parent_id => params[:parent_id],:category_id => params[:category_id]) 
    @categories = Category.all.map{|c| [ c.name, c.id ] }
    @post.sections.build
    @post.galleries.build
    @post.links.build
    @post.documents.build
  end

   def create
      @post = Post.new(post_params)
      #@post.category_id = params[:category_id] 
      @post.moderator_id = current_moderator.id
      if @post.save
        redirect_to admin_posts_url(cat: post_params[:category_id]), notice: 'Post was successfully created'
      else
        flash[:alert] = 'There was a problem creating post'
        render :new
      end
   end

  def edit
    @posts = Post.all
    @post = Post.find(params[:id])
    @categories = Category.all.map{|c| [ c.name, c.id ] }
    @section = Section.all
    @post.sections.build
    @post.galleries.build
    @post.links.build
    @post.documents.build
  end

  def update
    @post = Post.find(params[:id])
    @post.category_id = params[:category_id]
    if @post.update(post_params)
      #redirect_to admin_posts_url, notice: 'Post was successfully updated'
      redirect_to edit_admin_post_url(@post), notice: 'Post was successfully updated'
    else
      flash[:alert] = 'There was a problem updating post'
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])

  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy


    redirect_to :back, notice: 'Post was successfully deleted'
  end


  private

  def post_params
    params.require(:post).permit(:parent_id, :id, :title, :content, :publish, :image, :category_id, :ancestry,
                                  tag_ids: [], 
                                  sections_attributes: [:id, :title, :content, :post_id, :sectiontype, :_destroy],
                                  galleries_attributes: [:id, :title, :description],
                                  links_attributes: [:id, :title, :url],
                                  documents_attributes: [:id, :title, :description, :document]
    )
  end

end
