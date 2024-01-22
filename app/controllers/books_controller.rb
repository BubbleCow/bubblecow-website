class BooksController < ApplicationController
  before_action :authenticate_user!
  layout :set_layout
  
  # Call backs
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :set_genres, only: [:new, :edit]

  def index
    @books = current_user.editorial_staff? ? Book.all : @user.books
    authorize @books
    @page_title = "Books"
  end

  def show
    authorize @book
    @page_title = @book.title.titleize
    @order = @book.orders.new
    @orders = @book.orders.order(created_at: :desc)
  end

  def new
    @users = User.all.sort_by { |user| user.last_name }
    @user = current_user
    @book = @user.books.build
    @book.orders.build if @book.orders.blank?
    @page_title = 'New book'
    @genres = Genre.where(parent_id: nil)
    @products = Product.all
    authorize @book
  end
  
  def create
    @book = Book.new(book_params)
    @book.user = current_user.admin? ? User.find(@book.user_id) : current_user
    authorize @book
  
    if @book.save
      redirect_to dashboard_path, notice: "#{@book.title.titleize} was successfully created."
    else
      load_additional_resources
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
    @book.orders.destroy_all
    @book.destroy
    redirect_to books_path, notice: "#{@book.title.titleize} was successfully destroyed."
  end

  private
  
  def set_book
    @book = Book.friendly.find(params[:id])
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
    when 'show'
        'page_templates/page_medium'
    when 'index'
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
      orders_attributes: [:id, :product_id, :initial_unedited_manuscript]
      )
  end

  def load_additional_resources
    @users = User.all
    @genres = Genre.where(parent_id: nil)
    @products = Product.all
  end
end
