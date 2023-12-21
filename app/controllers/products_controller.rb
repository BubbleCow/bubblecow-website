class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  layout :set_layout

  def index
    @products = Product.all
    authorize @products
    @page_title = "Products"
  end

  def show
    authorize @product
    @page_title = @product.name.titleize
  end

  def new
    @product = Product.new
    authorize @product
    @page_title = "New product"
  end

  def edit
    authorize @product
    @page_title = "Edit #{@product.name.titleize}"
  end

  def create
    @product = Product.new(product_params)
    authorize @product
    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @product
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    authorize @product
    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :price_usd, :price_gbp, :price_eur, :price_aud, :price_nzd, :price_cad, :description)
    end

    def set_layout
      case action_name
      when  'new', 'edit'
          'page_templates/page_small'
      when 'index'
          'page_templates/page_medium'
      when
          'page_templates/page_large'
      else
        'application'
      end
    end

end
