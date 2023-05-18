class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :destroy]
  before_action :set_book, only: [:create, :new, :destroy]

  def index
    @orders = Order.all
  end

  def new
    @order = @book.orders.build
    @order.order_items.build
    @order.order_items.build(product: Product.new)
  end

  def show
    @products = @order.products
  end

  def create
    @order = @book.orders.build(order_params)
    @order.user = current_user
    @order.book = @book

    if @order.save
      # Redirect to wherever you want, example:
      redirect_to @book, notice: 'Order was successfully created.'
    else
      # Handle failure, example:
      render 'books/show'
    end
  end

  def destroy
    @order.destroy
    redirect_to @book, notice: 'Order was successfully destroyed.'
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def set_book
    @book = Book.friendly.find(params[:book_id])
  end

  def order_params
    params.require(:order).permit(:user_id, :book_id, product_ids: [])
  end
end
