class FaqsController < ApplicationController
  
  layout 'blank'
  
  before_action :require_login, :except => [:show]
  before_action :require_admin, :except => [:show]
  
  def new
    @faq = Faq.new
    @faq.category = params[:category]
  end
  
  def create
    @faq = Faq.new(faq_params)
    
    if @faq.save
      redirect_to root_path
    else
      flash[:error] = "Could not save FAQ."
      redirect_to new_faq_path
    end
    
  end
  
  def show
    @faq = Faq.friendly.find params[:id]
  end
  
  def edit
    @faq = Faq.friendly.find params[:id]
    # @Faq.references = [@Faq.references.build]
  end
  
  def up
    @faq = Faq.friendly.find params[:id]
    @faq.move_higher
    redirect_to root_path
  end
  
  def down
    @faq = Faq.friendly.find params[:id]
    @faq.move_lower
    redirect_to root_path
  end
  
  def destroy
    @faq = Faq.friendly.find params[:id]
    flash[:success] = "FAQ destroyed."
    @faq.destroy
    redirect_to root_path and return
  end
  
  def update
    @faq = Faq.friendly.find params[:id]

    if params[:commit] == "Delete"
      flash[:success] = "FAQ destroyed."
      @faq.destroy
      redirect_to root_path and return
    end

    if params[:commit] == "Edit"
      @faq.update_attributes(faq_params)

      if @faq.save

        if ref = faq_ref_params[:reference]
          if ref[:image]
            @reference = @faq.references.create!(
              :image => ref[:image].first,
              :faq => @faq)
          end
          if !ref[:web_url].blank?
            @reference = @faq.references.create!(
              :web_url => ref[:web_url],
              :faq => @faq)
          end

          if !ref[:youtube_url].blank?
            @reference = @faq.references.create!(
              :youtube_url => ref[:youtube_url],
              :faq => @faq)
          end  
        end
    
        flash[:success] = "FAQ saved."
        redirect_to @faq
      else
        flash[:error] = "FAQ failed to be saved."
        render 'edit'
      end
      
    else
      redirect_to edit_faq_path(@faq)
    end
  end
  
  protected
  
  # def faq_image_params
  #   params.require(:faq).require(:reference).require(:image)
  # end
  
  def faq_ref_params
    params.require(:faq).permit({reference: [:id, :youtube_url, :web_url, :image => []]})
  end
  
  def faq_params
    params.require(:faq).permit(:title, :body, :category, :type, {references: [:id]})
  end
  
end
