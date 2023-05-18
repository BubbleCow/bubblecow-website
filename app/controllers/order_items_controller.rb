class OrderItemsController < ApplicationController
      
    def create
      @order = current_order
      @order_item = @order.order_items.new(order_item_params)
      @order.book_id = params[:book_id] # Set the book_id from the params
  
      if @order_item.save
        # Order item was successfully created
        redirect_to @order.book, notice: 'Product added to order.'
      else
        # Handle validation errors
        render 'books/show'
      end
    end
  
  
    private
  
    def order_item_params
      params.require(:order_item).permit(:product_id, :quantity)
    end
  end
  