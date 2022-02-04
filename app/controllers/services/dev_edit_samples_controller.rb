module Services

  class DevEditSamplesController < Services::ApplicationController
    before_action :set_book
    before_action :set_dev_edit_sample, only: %i[ show edit update destroy]
    
    def index
      @dev_edit_samples = @book.dev_edit_samples
      authorize @dev_edit_samples
    end

    def show
      authorize @dev_edit_sample
    end

    def new
      @dev_edit_sample = @book.dev_edit_samples.build
      authorize @dev_edit_sample
    end

    def edit
      authorize @dev_edit_sample
    end

    def create
      @dev_edit_sample = @book.dev_edit_samples.create(dev_edit_sample_params)
      authorize @dev_edit_sample

      respond_to do |format|
        if @dev_edit_sample.save
          format.html { redirect_to services_book_path(@book), notice: "Sample developmental edit was successfully created." }
          format.json { render :show, status: :created, location: @dev_edit_sample }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @dev_edit_sample.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      authorize @dev_edit_sample
      
      respond_to do |format|
        if @dev_edit_sample.update(dev_edit_sample_params)
          format.html { redirect_to services_book_path(@book), notice: "Sample developmental edit was successfully updated." }
          format.json { render :show, status: :ok, location: @dev_edit_sample }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @dev_edit_sample.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      authorize @dev_edit_sample
      @dev_edit_sample.destroy
      respond_to do |format|
        format.html { redirect_to services_book_path(@book), notice: "Sample developmental edit was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private

      def set_book
        @book = Book.friendly.find(params[:book_id])
      end

      def set_dev_edit_sample
        @dev_edit_sample = DevEditSample.find(params[:id])
      end

      def dev_edit_sample_params
        params.require(:dev_edit_sample).permit(:book_id_integer, :aasm_state, :status, :user_id, :accepted_date, :rejected_date, :return_date, :unedited_manuscript, :editors_report, :edited_manuscript)
      end

  end

end