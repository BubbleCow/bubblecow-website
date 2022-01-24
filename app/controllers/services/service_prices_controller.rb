module Services
  
  class ServicePricesController < Services::ApplicationController
    before_action :set_service_price, only: [:show, :edit, :update, :destroy]
    layout 'backend'

    def index
        @service_prices = ServicePrice.all
        authorize  @service_prices
    end
  
    def show
        authorize  @service_price
    end
  
    def new
        @service_price = ServicePrice.new
        authorize  @service_price
    end
  
    def edit
        authorize  @service_price
    end
  
    def create
        @service_price = ServicePrice.new(service_price_params)
        authorize  @service_price
        respond_to do |format|
          if @service_price.save
            format.html { redirect_to services_service_prices_path, notice: 'Service price was successfully created.' }
          else
            format.html { render :new }
          end
        end
    end
  
    def update
        authorize  @service_price
        respond_to do |format|
          if @service_price.update(service_price_params)
            format.html { redirect_to services_service_prices_path, notice: 'Service price was successfully updated.' }
          else
            format.html { render :edit }
          end
        end
    end
  
    def destroy
        authorize  @service_price
        @service_price.destroy
        respond_to do |format|
          format.html { redirect_to services_service_prices_path, notice: 'Service price was successfully destroyed.' }
        end
    end
  
    private

        def set_service_price
            @service_price = ServicePrice.find(params[:id])
        end
  
        def service_price_params
            params.require(:service_price).permit(:service_type, :currency, :price)
        end

  end
end