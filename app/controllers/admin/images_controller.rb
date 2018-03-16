class Admin::ImagesController < Admin::ApplicationController
  # GET /images
  # GET /images.json
  def index

    @gallery = Gallery.find(params[:gallery_id])

    @images = @gallery.images

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @images }
    end
  end

  # GET /images/1
  # GET /images/1.json
  def show
    @image = Image.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @image }
    end
  end

  # GET /images/new
  # GET /images/new.json
  def new
    @gallery = Gallery.find(params[:gallery_id])
    @image = @gallery.images.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @image }
    end
  end

  # GET /images/1/edit
  def edit
    #@gallery = Gallery.find(params[:gallery_id])

    @image = Image.find(params[:id])
    @image = @gallery.images.build
    
  end

  # POST /images
  # POST /images.json
  def create
    @image = Image.new(params[:image])

    if @image.save
      respond_to do |format|
        format.html {
          render :json => [@image.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json {
          render :json => [@image.to_jq_upload].to_json
        }
      end
    else
      render :json => [{:error => "custom_failure"}], :status => 304
    end
  end

  # PUT /images/1
  # PUT /images/1.json
  def update

    @gallery = Gallery.find(params[:gallery_id])

    @image = @gallery.images.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(image_params)
        format.html { redirect_to admin_gallery_path(@gallery), notice: 'Picture was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    #@gallery = Gallery.find(params[:gallery_id])
    #@picture = @gallery.images.find(params[:id])
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def make_default
    @image = Image.find(params[:id])
    @gallery = Gallery.find(params[:gallery_id])

    @gallery.cover = @image.id
    @gallery.save

    respond_to do |format|
      format.js
    end
  end

  private

  def image_params
    params.require(:image).permit(:description, :gallery_id, :image)
  end
end