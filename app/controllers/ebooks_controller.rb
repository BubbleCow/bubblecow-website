class EbooksController < ApplicationController
    before_action :set_ebook, only: [:show, :edit, :update]
    layout :set_layout
    before_action :redirect_unauthenticated_users, only: [:show]
  
    def index
      @ebooks = Ebook.all
      authorize @ebooks
    end
  
    def show
      authorize @ebook
    end
  
    def new
      @ebook = Ebook.new
      authorize @ebook
    end
  
    def create
      @ebook = Ebook.new(ebook_params)
      authorize @ebook
      if @ebook.save
        redirect_to ebooks_url, notice: 'eBook was successfully created.'
      else
        render :new
      end
    end
  
    def edit
      authorize @ebook
    end
  
    def update
      authorize @ebook
      if @ebook.update(ebook_params)
        redirect_to @ebook, notice: 'eBook was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      authorize @ebook
      @ebook.destroy
      respond_to do |format|
        format.html { redirect_to ebooks_url, notice: 'Ebook was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  
    private
  
    def set_ebook
      @ebook = Ebook.friendly.find(params[:id])
    end
  
    def ebook_params
      params.require(:ebook).permit(:title, :description, :version, :cover, :pdf_file, :epub_file)
    end

    def set_layout
      case action_name
      when 'new', 'edit'
          'page_templates/page_small'
      when 'index', 'show'
          'page_templates/page_medium'
      when 
          'page_templates/page_large'
      else
        'application'
      end
    end

    def redirect_unauthenticated_users
      unless user_signed_in?
        redirect_to free_signup_path
      end
    end
    
  end
  