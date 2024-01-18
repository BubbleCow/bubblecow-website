class BooksController < ApplicationController
  before_action :authenticate_user!
  layout :set_layout
  
  # Call backs
  before_action :set_user
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :set_genres, only: [:new, :edit]

  def index
    @books = @user.books
    authorize @books
    @page_title = "Books for #{@user.full_name}"
  end

  def show
    authorize @book
    @page_title = @book.title.titleize
    @order = @book.orders.new
    @orders = @book.orders.order(created_at: :desc)
  end

  def new
    @users = User.all.sort_by { |user| user.last_name }
    @book = @user.books.build
    @page_title = 'New book'
    @genres = Genre.where(parent_id: nil)
    authorize @book
  end

  def create
    @book = Book.new(book_params)
    authorize @book
    if current_user.admin?
      @user = User.find(@book.user_id) # use the user_id from the form for admin
    else
      @user = current_user # use the current user for non-admins
      @book.user_id = @user.id # set the book user_id to current user
    end
  
    @book.user = @user
  
    if @book.save
      flash[:success] = "#{@book.title.titleize} was successfully created."
      redirect_to dashboard_path, notice: "#{@book.title.titleize} was successfully created."
    else
      @users = User.all
      @genres = Genre.where(parent_id: nil)
      render :new, status: :unprocessable_entity
    end
  end    
    
  def edit
    @page_title = "Edit #{@book.title.titleize}"
  end

  def update
    authorize @book
    if @book.update(book_params)
      redirect_to [@book.user, @book], notice: "#{@book.title.titleize} was successfully updated."
    else
      render :edit
    end
  end
  
  def destroy
    authorize @book
    @book.destroy
    redirect_to user_books_url(@book.user), notice: "#{@book.title.titleize} was successfully destroyed."
  end

  private

  def set_user
    @user = current_user
  end
  
  def set_book
    @book = @user.books.friendly.find(params[:id])
  end

  def set_writers
    @writers = User.all
  end
  
  def set_genres
    @genres = Genre.all
  end

  def set_layout
    case action_name
    when 'new', 'create'
        'page_templates/page_small'
    when
        'page_templates/page_medium'
    when 
        'page_templates/page_large'
    else
      'application'
    end
  end

  # Only allow a list of trusted parameters through.
  def book_params
    params.require(:book).permit(
      :title, 
      :description, 
      :word_count, 
      :language,
      :genre_id, 
      :user_id,
      book_products_attributes: [:id, :product_id, :initial_unedited_manuscript]
      )
  end
end
