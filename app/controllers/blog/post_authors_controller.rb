module Blog
  class PostAuthorsController < Blog::ApplicationController
    before_action :set_post_author, only: [:show, :edit, :update, :destroy]

    def index
      @post_authors = PostAuthor.all
      authorize @post_authors
    end

    def show
      authorize @post_author
      @categories = PostCategory.all
      @page_title = "Articles written by" + " " + @post_author.name
      @page_description = 'The complete collection of articles written by' + " " + @post_author.name
    end

    def new
      @post_author = PostAuthor.new
      authorize @post_author
    end

    def edit
      authorize @post_author
    end

    def create
      @post_author = PostAuthor.new(post_author_params)
      authorize @post_author
      respond_to do |format|
        if @post_author.save
          format.html { redirect_to admin_dashboard_path, notice: 'Post author was successfully created.' }
          format.json { render :show, status: :created, location: @post_author }
        else
          format.html { render :new }
          format.json { render json: @post_author.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      authorize @post_author
      respond_to do |format|
        if @post_author.update(post_author_params)
          format.html { redirect_to admin_dashboard_path, notice: 'Post author was successfully updated.' }
          format.json { render :show, status: :ok, location: @post_author }
        else
          format.html { render :edit }
          format.json { render json: @post_author.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      authorize @post_author
      @post_author.destroy
      respond_to do |format|
        format.html { redirect_to admin_dashboard_path, notice: 'Post author was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      def set_post_author
        @post_author = PostAuthor.friendly.find(params[:id])
      end

      def post_author_params
        params.require(:post_author).permit(:name, :slug)
      end
  end
end