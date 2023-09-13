class BooksController < ApplicationController
  before_action :authenticate_user!
  
  # Call backs
  before_action :set_user
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :set_writers, only: [:new, :edit]
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
    @user = User.friendly.find(params[:user_id])
    @book = @user.books.build
    @page_title = 'New book'
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
      redirect_to [@book.user, @book], notice: "#{@book.title.titleize} was successfully created."
    else
      @writers = User.writer.all
      render :new
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
    @user = User.friendly.find(params[:user_id])
  end
  
  def set_book
    @book = @user.books.friendly.find(params[:id])
  end

  def set_writers
    @writers = User.writer.all
  end
  
  def set_genres
    @genres = Genre.all
  end

  # Only allow a list of trusted parameters through.
  def book_params
    params.require(:book).permit(
      :title, 
      :description, 
      :word_count, 
      :language,
      :genre, 
      :user_id,
      book_products_attributes: [:id, :product_id, :initial_unedited_manuscript]
      )
  end
end
