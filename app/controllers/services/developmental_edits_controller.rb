module Services

  class DevelopmentalEditsController < Services::ApplicationController
    before_action :set_developmental_edit, only: [:show, :edit, :update, :destroy]
    layout :set_layout

    def index
      @developmental_edits = DevelopmentalEdit.all
      @developmetal_edits_submitted = DevelopmentalEdit.developmental_edit_submitted
      @developmental_edits_accepted = DevelopmentalEdit.developmental_edit_accepted
      @developmental_edits_rejected = DevelopmentalEdit.developmental_edit_rejected
      @developmental_edit_invoice_sent = DevelopmentalEdit.developmental_edit_invoice_sent
      @developmental_edit_invoice_paid = DevelopmentalEdit.developmental_edit_invoice_paid
      @developmental_edit_editing_underway = DevelopmentalEdit.developmental_edit_editing_underway.sorted_by_due_date
      @developmental_edits_returned = DevelopmentalEdit.developmental_edit_returned
      authorize @developmental_edits
    end

    def show
      @page_title = @developmental_edit.title.titleize
      @editors = User.editor
      authorize @developmental_edit
    end

    def new
      @developmental_edit = current_user.developmental_edits.new
      authorize @developmental_edit
    end

    def edit
      authorize @developmental_edit
    end

    def create
      @developmental_edit = current_user.developmental_edits.new(developmental_edit_params)
      authorize @developmental_edit
      respond_to do |format|
        if @developmental_edit.save
          format.html { redirect_to services_developmental_edit_path(@developmental_edit), notice: "#{@developmental_edit.title.titleize} was successfully created." }
          format.json { render :show, status: :created, location: @developmental_edit }
        else
          format.html { render :new }
          format.json { render json: @developmental_edit.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      authorize @developmental_edit
      respond_to do |format|
        if @developmental_edit.update(developmental_edit_params)
          format.html { redirect_to services_developmental_edit_path(@developmental_edit), notice: "#{@developmental_edit.title.titleize} was successfully updated." }
          format.json { render :show, status: :ok, location: @developmental_edit }
        else
          format.html { render :edit }
          format.json { render json: @developmental_edit.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      authorize @developmental_edit
      @developmental_edit.destroy
      respond_to do |format|
        format.html { redirect_to user_path(@developmental_edit.user), status: :see_other, notice: "Developmental Edit was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private
      def set_developmental_edit
        @developmental_edit = DevelopmentalEdit.friendly.find(params[:id])
      end

      def developmental_edit_params
        params.require(:developmental_edit).permit(:title, :user_id, :slug, :word_count, :language, :description, :genre_id, :full_manuscript, :edited_manuscript, :editors_report, :note, :aasm_state, :invoice_due_date, :invoice_paid_date, :developmental_edit_due_date, :editor_id, :edit_return_date)
      end

      def set_layout
        case action_name
        when 'new', 'edit'
            'page_templates/page_small'
        when 
            'page_templates/page_medium'
        when 
            'page_templates/page_large'
        else
          'application'
        end
      end

  end
end
