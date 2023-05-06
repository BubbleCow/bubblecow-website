module Services

  class DevEditsController < Services::ApplicationController
    before_action :set_book
    before_action :set_dev_edit, only: %i[ show edit update destroy ]
    after_action :set_currency

    def index
      @dev_edits = @book.dev_edits
      authorize @dev_edits
    end

    def show
      authorize @dev_edit
    end

    def new
      @dev_edit = @book.dev_edits.build
      authorize @dev_edit
    end

    def edit
      authorize @dev_edit
    end

    def create
      @dev_edit = @book.dev_edits.create(dev_edit_params)
      authorize @dev_edit

      # Send tag to Active Campaign
      # # ActiveCampaignService.new.contact_tag_add(@dev_edit.book.user, "BubbleCow - Product - Developmental Editing - Submitted")

      respond_to do |format|
        if @dev_edit.save
          format.html { redirect_to services_book_path(@book), notice: "Developmental edit was successfully created." }
          format.json { render :show, status: :created, location: @dev_edit }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @dev_edit.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      authorize @dev_edit
      respond_to do |format|
        if @dev_edit.update(dev_edit_params)
          format.html { redirect_to services_book_path(@book), notice: "Developmental edit was successfully updated." }
          format.json { render :show, status: :ok, location: @dev_edit }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @dev_edit.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      authorize @dev_edit
      @dev_edit.destroy
      respond_to do |format|
        format.html { redirect_to services_book_path(@book), notice: "Developmental edit was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private
     
      def set_book
        @book = Book.friendly.find(params[:book_id])
      end

      def set_dev_edit
        @dev_edit = DevEdit.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def dev_edit_params
        params.require(:dev_edit).permit(:book_id, :aasm_state, :status, :user_id, :accepted_date, :rejected_date, :invoice_due_date, :due_date, :invoice_paid_date, :return_date, :unedited_manuscript, :editors_report, :edited_manuscript, :status_value)
      end

      # Sets the currency for the user

      def set_currency

          case @book.user.country

          when 'United States'

            @book.user.update(currency: 'usd')
        
          when 'United Kingdom'
        
            @book.user.update(currency: 'gbp')
        
          when 'Canada'
        
            @book.user.update(currency: 'cad')
        
          when'Europe'
        
            @book.user.update(currency: 'euro')
        
          when 'Australia'
        
            @book.user.update(currency: 'aud')
        
          when 'New Zealand'
        
            @book.user.update(currency: 'nzd')
            
          else 
        
            @book.user.update(currency: 'usd')
        
          end

      end

  end

end
