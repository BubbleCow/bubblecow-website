module Services

  class GenresController < Services::ApplicationController
    skip_before_action :authenticate_user!, only: [:show]
    before_action :set_genre, only: [:show, :edit, :update, :destroy]
    before_action :set_admin_nav_bar
    layout 'admin_template'

    def index
      @genres = Genre.all
      authorize @genres
    end

    def show
      authorize @genre
    end

    def new
      @genre = Genre.new
      authorize @genre
    end

    def edit
      authorize @genre
    end

    def create
      @genre = Genre.new(genre_params)
      authorize @genre
      respond_to do |format|
        if @genre.save
          format.html { redirect_to admin_area_genres_path, notice: 'Genre was successfully created.' }
          format.json { render :show, status: :created, location: @genre }
        else
          format.html { render :new }
          format.json { render json: @genre.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      authorize @genre
      respond_to do |format|
        if @genre.update(genre_params)
          format.html { redirect_to admin_area_genres_path, notice: 'Genre was successfully updated.' }
          format.json { render :show, status: :ok, location: @genre }
        else
          format.html { render :edit }
          format.json { render json: @genre.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      authorize @genre
      @genre.destroy
      respond_to do |format|
        format.html { redirect_to admin_area_genres_path, notice: 'Genre was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_genre
        @genre = Genre.friendly.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def genre_params
        params.require(:genre).permit(:genre_type, :slug)
      end

      def set_admin_nav_bar
        @unread_messages = Message.unread
        @unprocessed_developmental_edits = DevelopmentalEdit.developmental_edit_submitted
        @unprocessed_sample_developmental_edits = SampleDevelopmentalEdit.sample_developmental_edit_submitted
      end

  end

end
