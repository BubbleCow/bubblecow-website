module Services
  
  class DevelopmentalEditsController < Services::ApplicationController
    before_action :authenticate_user!
    before_action :set_developmental_edit, only: [:show, :edit, :update, :destroy]

    def index
      @developmental_edits = current_user.developmental_edits.all
      authorize @developmental_edits
    end

    def show
      @page_title = @developmental_edit.title.titleize
      authorize @developmental_edit
      if current_user.admin?
        render layout: 'admin_template'
      end
    end

    def new
      @developmental_edit = current_user.developmental_edits.new
    end

    def edit
    end

    def create
      @developmental_edit = current_user.developmental_edits.new(developmental_edit_params)

      respond_to do |format|
        if @developmental_edit.save
          
          # Deliver email
          DevelopmentalEditMailer.new_developmental_edit(@developmental_edit.user).deliver_now

          format.html { redirect_to root_path, notice: "#{@developmental_edit.title.titleize} was successfully created." }
          format.json { render :show, status: :created, location: @developmental_edit }
        else
          format.html { render :new }
          format.json { render json: @developmental_edit.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
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
      @developmental_edit.destroy
      respond_to do |format|
        format.html { redirect_to admin_area_services_path, notice: 'Developmental edit was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      def set_developmental_edit
        @developmental_edit = DevelopmentalEdit.friendly.find(params[:id])
      end

      def developmental_edit_params
        params.require(:developmental_edit).permit(:title, :user_id, :slug, :word_count, :language, :description, :genre_id, :full_manuscript, :note, :aasm_state)
      end

  end
end
