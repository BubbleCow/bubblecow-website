class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy, :read, :unread, :archive, :unarchive]
  before_action :authenticate_user!, only: [:index, :show, :destroy]
  before_action :set_side_nav_bar, only: [:index, :show]
  layout :set_template

  def index
    @messages = Message.all
    @unread_messages = Message.unread
    @read_messages = Message.read
    @archived_messages = Message.archived
    authorize @messages
  end

  def show
    authorize @message
    @message.mark_as_read(@message)
  end

  def new
    @message = Message.new
    authorize @message
  end

  def edit
    authorize @message
  end

  def create
    @message = Message.new(message_params)
    authorize @message
    respond_to do |format|
      if @message.save
        # Deliver the message email
        MessageMailer.new_message(@message).deliver_now
        
        format.html { redirect_to thank_you_path, notice: 'Message was successfully sent.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @message
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @message
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def read
    @message.update(read: true)
    redirect_to messages_path
  end

  def unread
    @message.update(read: false)
    redirect_to messages_path
  end

  def archive
    @message.update(archived: true)
    redirect_to messages_path
  end

  def unarchive
    @message.update(archived: false)
    redirect_to messages_path
  end

  def thank_you
  end

  private
    def set_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.require(:message).permit(:sender_name, :content, :sender_email, :read, :archived)
    end

    def set_side_nav_bar
      @unread_messages = Message.unread
      @unprocessed_developmental_edits = DevelopmentalEdit.developmental_edit_submitted
      @unprocessed_sample_developmental_edits = SampleDevelopmentalEdit.sample_developmental_edit_submitted
    end

    def set_template
      case action_name
      when 'index', 'show'
          'admin_template'
      else
          'application'
      end
    end

end
