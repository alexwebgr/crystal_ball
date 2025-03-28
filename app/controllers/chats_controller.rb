class ChatsController < ApplicationController
  before_action :set_chat, only: %i[ show edit update destroy ask ]

  # GET /chats
  def index
  end

  # GET /chats/1
  def show
  end

  def ask
    # Use a background job to avoid blocking
    ChatJob.perform_later(@chat.id, params[:message])

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @chat }
    end
  end

  # GET /chats/new
  def new
    chat = Current.user.chats.create!

    redirect_to chat_path(chat)
  end

  # GET /chats/1/edit
  def edit
  end

  # PATCH/PUT /chats/1
  def update
    if @chat.update(chat_params)
      redirect_to @chat, notice: "Chat was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /chats/1
  def destroy
    @chat.destroy!
    redirect_to chats_path, notice: "Chat was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Current.user.chats.find_by(id: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def chat_params
      params.expect(chat: [ :label ])
    end
end
