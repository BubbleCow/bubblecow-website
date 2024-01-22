class OrdersController < ApplicationController
  before_action :set_book
  before_action :set_order, only: [:show, :update, :destroy, :update_state, :send_invoice]

  def new
    @order = @book.orders.build
  end

  def show
    @page_title = @book.title.titleize
  end

  def create
    @order = @book.orders.build(order_params)
  
    if @order.save
      redirect_to user_book_path(@book.user, @book), notice: 'Product was successfully associated.'
    else
      redirect_to user_book_path(@book.user, @book), flash: { error: @order.errors.full_messages }
    end
  end
  
  def update
    if @order.update(order_params)
      redirect_to user_book_path(@book.user, @book), notice: 'Order was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @order.destroy
    redirect_to user_book_path(@book.user, @book), notice: 'Product was successfully removed.'
  end

  def update_state
    if current_user.admin?
      case params[:new_state]
      when 'accepted'
        @order.accept! if @order.may_accept?
      when 'rejected'
        @order.reject! if @order.may_reject?
      end

      # Redirect or render with a notice depending on the outcome
      redirect_to book_path(@book), notice: 'Order state updated.'
    else
      # Handle unauthorized access
      redirect_to order_path(@order), alert: 'You are not authorized to perform this action.'
    end
  end

  def send_invoice
    order_manager = OrderStateManager.new(@order)
    order_manager.send_invoice
  
    if @order.save
      redirect_to book_path(@book), notice: 'Invoice sent successfully.'
    else
      redirect_to book_path(@book), alert: 'Error sending invoice.'
    end
  end

  private

  def set_book
    @book = Book.friendly.find(params[:book_id])
  end

  def set_order
    @order = @book.orders.find(params[:id])
  end

  def order_params
    params.require(:order).permit(
      :product_id, 
      :editor_id, 
      :initial_unedited_manuscript,
      :invoice_due_date
    )
  end
end
