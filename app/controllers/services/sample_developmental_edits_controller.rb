module Services

  class SampleDevelopmentalEditsController < Services::ApplicationController
    before_action :authenticate_user!
    before_action :set_sample_developmental_edit, only: [:show, :edit, :update, :destroy]
    layout :set_template

    def index
      @sample_developmental_edits = SampleDevelopmentalEdit.all
      authorize @sample_developmental_edits
    end

    def show
      @page_title = @sample_developmental_edit.title.titleize
      @editors = User.editor
      authorize @sample_developmental_edit
      if current_user.admin?
        render layout: 'admin_template'
      end
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
      authorize @sample_developmental_edit
      respond_to do |format|
        if @sample_developmental_edit.save
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
        format.html { redirect_to admin_area_services_path, notice: 'Sample developmental edit was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      def set_sample_developmental_edit
        @sample_developmental_edit = SampleDevelopmentalEdit.friendly.find(params[:id])
      end

      def sample_developmental_edit_params
        params.require(:sample_developmental_edit).permit(:title, :user_id, :editor_id, :slug, :word_count, :language, :description, :genre_id, :aasm_state, :description, :sample_developmental_edit_manuscript, :sample_editors_report, :sample_edited_manuscript, :note, :sample_edit_return_date )
      end

      def set_template
          case action_name
          when 'index'
              'admin_template'
          else
              'application'
          end
      end
    

  end
end
