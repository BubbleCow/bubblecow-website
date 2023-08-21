class BooksController < ApplicationController
    before_action :set_book, only: %i[ show edit update destroy ]

    def index
      if current_user.writer?
        @books = current_user.books
        @page_title = "Your Books"
        @page_description = "A list of all your books."
      elsif current_user.admin?
        @books = Book.all
        @page_title = "All Books"
        @page_description = "A list of all books."
      end
      authorize @books
    end
  
    def show
      authorize @book
      @page_title = @book.title.titleize
      @order = Order.new(book: @book)
      @orders = @book.orders
    end
  
    def new
      @book = current_user.books.new
      @page_title = "Create a new book"
      @page_description = "Create and submit a book to BubbleCow."
      authorize @book
    end
  
    def edit
      authorize @book
      @page_title = @book.title
    end
  
    def create
      @book = current_user.books.new book_params
      authorize @book

      # Send tag to Active Campaign
      # ActiveCampaignService.new.contact_tag_add(@book.user, "BubbleCow - Book - Created")

      respond_to do |format|
        if @book.save
          format.html { redirect_to @book, notice: "Book was successfully created." }
          format.json { render :show, status: :created, location: @book }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def update
      authorize @book
      respond_to do |format|
        if @book.update(book_params)
          format.html { redirect_to @book, notice: "Book was successfully updated." }
          format.json { render :show, status: :ok, location: @book }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def destroy
      authorize @book
      @book.destroy
      respond_to do |format|
        format.html { redirect_to users_path, notice: "Book was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  
    private
  
      def set_book
        @book = Book.friendly.find(params[:id])
      end
      
      # Only allow a list of trusted parameters through.
      def book_params
        params.require(:book).permit(:title, :user, :language, :genre, :word_count, :description)
      end
  end
