class OrdersController < ApplicationController
  before_action :set_book
  before_action :set_order, only: [:show, :edit, :update, :destroy, :accept, :reject, :invoice_sent, :invoice_paid, :invoice_unpaid]

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

  def accept
    if @order.may_accept?
      @order.accept!
      redirect_to user_book_path(@book.user, @book)
    else
      render :edit
    end
  end

  def reject
    if @order.may_reject?
      @order.reject!
      redirect_to user_book_path(@book.user, @book)
    else
      render :edit
    end
  end

  def invoice_sent
    @order.invoice_sent_at = order_params[:invoice_sent_at]
    if @order.save
      @order.invoice_sent!
      redirect_to user_book_path(@book.user, @book)
    else
      render :edit
    end
  end

  def invoice_paid
    if @order.may_invoice_paid?
      @order.invoice_paid!
      redirect_to user_book_path(@book.user, @book)
    else
      render :edit
    end
  end
  
  def invoice_unpaid
    if @order.may_invoice_unpaid?
      @order.invoice_unpaid!
      redirect_to user_book_path(@book.user, @book)
    else
      render :edit
    end
  end

  def assign_editor
    if @order.update(order_params) && @order.may_assign_editor?
      @order.assign_editor!
      redirect_to user_book_path(@book.user, @book)
    else
      render :edit
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
      :edited_manuscript_for_paid_developmental_edit, 
      :editors_report_for_paid_developmental_edit, 
      :invoice_sent_at, 
      :invoice_paid_at, 
      :product_due_date,
      :product_returned_on
    )
  end
end
