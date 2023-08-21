class GenresController < ApplicationController
    before_action :set_genre, only: [:show, :edit, :update, :destroy]
  
    def index
      @genres = Genre.all
      authorize @genres
    end
  
    def new
      @genre = Genre.new
      authorize @genre
    end

    def show
      authorize @genre
    end
  
    def create
      @genre = Genre.new(genre_params)
      authorize @genre
      if @genre.save
        redirect_to genres_path, notice: 'Genre was successfully created.'
      else
        render :new
      end
    end
  
    def edit
      authorize @genre
    end
  
    def update
      authorize @genre
      if @genre.update(genre_params)
        redirect_to genres_path, notice: 'Genre was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @genre.destroy
      authorize @genre
      redirect_to genres_path, notice: 'Genre was successfully deleted.'
    end

    private
  
    def set_genre
      @genre = Genre.friendly.find(params[:id])
    end
  
    def genre_params
      params.require(:genre).permit(:genre_type)
    end
  end
  