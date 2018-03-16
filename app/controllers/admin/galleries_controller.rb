class Admin::GalleriesController < Admin::ApplicationController

  def index
   @galleries = Gallery.all

  end

  def new
    @galleries = Gallery.all
    @gallery = Gallery.new
  end

 def create
    @gallery = Gallery.new(gallery_params)

    respond_to do |format|
      if @gallery.save

        if params[:images]
          # The magic is here ;)
          params[:images].each { |image|
            @gallery.images.create(image: image)
          }
        end

        format.html { redirect_to @gallery, notice: 'Gallery was successfully created.' }
        format.json { render json: @gallery, status: :created, location: @gallery }
      else
        format.html { render action: "new" }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
     @gallery = Gallery.find(params[:id])
  end

  def update

     @gallery = Gallery.find(params[:id])

      respond_to do |format|
        if @gallery.update_attributes(gallery_params)
          if params[:images]
            # The magic is here ;)
            params[:images].each { |image|
              @gallery.images.create(image: image)
            }
          end
          format.html { redirect_to admin_gallery_url, notice: 'Gallery was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @gallery.errors, status: :unprocessable_entity }
        end
      end


  end

  def show
    @gallery  = Gallery.find(params[:id])
    @images = @gallery.images
  end

  def destroy
    @gallery = Gallery.find(params[:id])
    @gallery.destroy

    respond_to do |format|
      format.html { redirect_to admin_gallery_url }
      format.json { head :no_content }
    end
  end

private

  def gallery_params
    params.require(:gallery).permit(:name, :images)
  end  
end
