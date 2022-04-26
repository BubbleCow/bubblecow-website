module Blog
  class PostsController < Blog::ApplicationController
    before_action :set_post, only: [:show, :edit, :update, :destroy, :publish, :unpublish]
    layout :set_template

    def index
      @posts = Post.published
      @categories = PostCategory.all
      authorize @posts
      @page_title = 'BubbleCow Blog' 
      @page_description = 'Empowering self-published writers to be successful.'
    end

    def show
      authorize @post
      @page_title = @post.seo_title 
      @page_description = @post.seo_description.to_s
      @page_keywords = @post.keywords
      @writing_manual = MailingList.new
      ahoy.track "Viewed Article", title: @post.post_title
      @data_type = "blog_post"
    end

    def new
      @post = Post.new
      authorize @post
    end

    def edit
      authorize @post
    end

    def create
      @post = Post.new(post_params)
      authorize @post
      respond_to do |format|
        if @post.save
          format.html { redirect_to edit_blog_post_path(@post), notice: 'Post was successfully saved. This is not published.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      authorize @post
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to edit_blog_post_path(@post), notice: 'Post was successfully saved.' }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      authorize @post
      @post.destroy
      respond_to do |format|
        format.html { redirect_to blog_posts_url, notice: 'Post was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    def publish
      @post.update(published: true)
      redirect_to admin_dashboard_path
    end

    def unpublish
      @post.update(published: false)
      redirect_to admin_dashboard_path
    end
    
    private
      def set_post
        @post = Post.friendly.find(params[:id])
      end

      def post_params
        params.require(:post).permit(:title, :slug, :post_category_id, :post_author_id, :seo_description, :post_description, :body, :post_image, :name, :permalink, :keywords, :published, :seo_title, :post_title, :topic_list)
      end
      
      def set_template
        case action_name
        when 'edit', 'new'
            'backend_blog'
        else
            'application'
        end
      end

  end
end
