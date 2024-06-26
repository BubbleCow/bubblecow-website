module Services

  class SampleDevelopmentalEditsController < Services::ApplicationController
    before_action :set_sample_developmental_edit, only: [:show, :edit, :update, :destroy]
    before_action :set_service_price, only: [:new, :edit, :update]
    layout :set_layout

    def index
      @sample_developmental_edits = SampleDevelopmentalEdit.all
      @sample_developmental_edit_submitted =  SampleDevelopmentalEdit.sample_developmental_edit_submitted
      @sample_developmental_edit_accepted =  SampleDevelopmentalEdit.sample_developmental_edit_accepted
      @sample_developmental_edit_editing_underway =  SampleDevelopmentalEdit.sample_developmental_edit_editing_underway
      authorize @sample_developmental_edits
    end

    def show
      @page_title = @sample_developmental_edit.title.titleize
      @editors = User.editor
      authorize @sample_developmental_edit
    end

    def new
      @sample_developmental_edit = current_user.sample_developmental_edits.new
      authorize @sample_developmental_edit
    end

    def edit
      authorize @sample_developmental_edit
    end

    def create
      @sample_developmental_edit = current_user.sample_developmental_edits.new(sample_developmental_edit_params)
      @service_price = ServicePrice.find_by(currency: current_user.currency)
      authorize @sample_developmental_edit
      respond_to do |format|
        if @sample_developmental_edit.save
          @sample_developmental_edit.calculate_developmental_edit_quote(@service_price.price)
          format.html { redirect_to services_sample_developmental_edit_path(@sample_developmental_edit), notice: "#{@sample_developmental_edit.title.titleize} was successfully created." }
          format.json { render :show, status: :created, location: @sample_developmental_edit }
        else
          format.html { render :new }
          format.json { render json: @sample_developmental_edit.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      authorize @sample_developmental_edit
      respond_to do |format|
        if @sample_developmental_edit.update(sample_developmental_edit_params)
          @sample_developmental_edit.calculate_developmental_edit_quote(@service_price.price)
          format.html { redirect_to services_sample_developmental_edit_path(@sample_developmental_edit), notice: "#{@sample_developmental_edit.title.titleize} was successfully updated." }
          format.json { render :show, status: :ok, location: @sample_developmental_edit }
        else
          format.html { render :edit }
          format.json { render json: @sample_developmental_edit.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      authorize @sample_developmental_edit
      @sample_developmental_edit.destroy
      respond_to do |format|
        format.html { redirect_to user_path(@sample_developmental_edit.user), status: :see_other, notice: "Sample Developmental Edit was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private
      def set_sample_developmental_edit
        @sample_developmental_edit = SampleDevelopmentalEdit.friendly.find(params[:id])
      end

      def sample_developmental_edit_params
        params.require(:sample_developmental_edit).permit(:title, :user_id, :editor_id, :slug, :word_count, :language, :description, :genre_id, :aasm_state, :description, :sample_developmental_edit_manuscript, :sample_editors_report, :sample_edited_manuscript, :note, :sample_edit_return_date, :developmental_editing_quote )
      end
    
      def set_service_price
        @service_price = ServicePrice.find_by(currency: current_user.currency)
      end

      def set_layout
        case action_name
        when 'new', 'edit'
            'page_templates/page_small'
        when 
            'page_templates/page_medium'
        when 'show', 'index'
            'page_templates/page_large'
        else
          'application'
        end
      end

    end
end