module Blog
  class PostCategoriesController < Blog::ApplicationController
    before_action :set_post_category, only: [:show, :edit, :update, :destroy]
    layout :set_layout

    # Display all categories, optionally in a hierarchical manner
    def index
      @post_categories = PostCategory.all.order(:name)
      @parent_categories = PostCategory.where(parent_category_id: nil).order(:name)
      authorize @post_categories
    end

    # Show a specific category
    def show
      authorize @post_category
      @categories = PostCategory.all
      @posts = @post_category.posts.published.order(created_at: :asc)
      @page_title = "Articles in the category" + " " + @post_category.name
      @page_description = 'The complete collection of articles in the category' + " " + @post_category.name
    end

    # Form for creating a new category
    def new
      @post_category = PostCategory.new
      authorize @post_category
    end

    # Form for editing an existing category
    def edit
      authorize @post_category
    end

    # Create a new category
    def create
      @post_category = PostCategory.new(post_category_params)
      authorize @post_category
      respond_to do |format|
        if @post_category.save
          format.html { redirect_to blog_post_categories_path, notice: 'Post category was successfully created.' }
          format.json { render :show, status: :created, location: @post_category }
        else
          format.html { render :new }
          format.json { render json: @post_category.errors, status: :unprocessable_entity }
        end
      end
    end

    # Update an existing category
    def update
      authorize @post_category
      respond_to do |format|
        if @post_category.update(post_category_params)
          format.html { redirect_to blog_post_categories_path, notice: 'Post category was successfully updated.' }
          format.json { render :show, status: :ok, location: @post_category }
        else
          format.html { render :edit }
          format.json { render json: @post_category.errors, status: :unprocessable_entity }
        end
      end
    end

    # Delete a category
    def destroy
      authorize @post_category
      if @post_category.child_categories.any?
        redirect_to blog_post_categories_path, alert: 'Cannot delete a category that has child categories.'
      else
        @post_category.destroy
        respond_to do |format|
          format.html { redirect_to blog_post_categories_path, notice: 'Post category was successfully destroyed.' }
          format.json { head :no_content }
        end
      end
    end

    private

      def set_post_category
        @post_category = PostCategory.friendly.find(params[:id])
      end

      def post_category_params
        params.require(:post_category).permit(:name, :slug, :parent_category_id)
      end

      def set_layout
        case action_name
        when 'index', 'new', 'edit', 'show'
          'page_templates/page_medium'
        else
          'application'
        end
      end
  end
end
