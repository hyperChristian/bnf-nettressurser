class Admin::SectionsController < Admin::ApplicationController
  def index
  	@sections = Section.all
  end

  def new
  end

  def create
  end

  def edit
    @section = Section.find(params[:id])
    
  end

  def update
  end

  def show
  end

  def destroy
    @section = Section.find(params[:id])
    @section.destroy


    redirect_to :back, notice: 'Section was successfully deleted'	
  end  
end
