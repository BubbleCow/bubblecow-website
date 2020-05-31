module Services
  class DevelopmentalEditsController < Services::ApplicationController
    before_action :set_developmental_edit, only: [:show, :edit, :update, :destroy]

    # GET /developmental_edits
    # GET /developmental_edits.json
    def index
      @developmental_edits = DevelopmentalEdit.all
    end

    # GET /developmental_edits/1
    # GET /developmental_edits/1.json
    def show
    end

    # GET /developmental_edits/new
    def new
      @developmental_edit = DevelopmentalEdit.new
    end

    # GET /developmental_edits/1/edit
    def edit
    end

    # POST /developmental_edits
    # POST /developmental_edits.json
    def create
      @developmental_edit = current_user.developmental_edits.new(developmental_edit_params)

      respond_to do |format|
        if @developmental_edit.save
          format.html { redirect_to root_path, notice: 'Developmental edit was successfully created.' }
          format.json { render :show, status: :created, location: @developmental_edit }
        else
          format.html { render :new }
          format.json { render json: @developmental_edit.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /developmental_edits/1
    # PATCH/PUT /developmental_edits/1.json
    def update
      respond_to do |format|
        if @developmental_edit.update(developmental_edit_params)
          format.html { redirect_to root_path, notice: 'Developmental edit was successfully updated.' }
          format.json { render :show, status: :ok, location: @developmental_edit }
        else
          format.html { render :edit }
          format.json { render json: @developmental_edit.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /developmental_edits/1
    # DELETE /developmental_edits/1.json
    def destroy
      @developmental_edit.destroy
      respond_to do |format|
        format.html { redirect_to developmental_edits_url, notice: 'Developmental edit was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_developmental_edit
        @developmental_edit = DevelopmentalEdit.friendly.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def developmental_edit_params
        params.require(:developmental_edit).permit(:title, :user_id, :slug)
      end

  end
end
