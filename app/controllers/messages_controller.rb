require 'redis_handler'
class MessagesController < ApplicationController
  before_action :app_chat_id
  # before_action :set_message, only: [:show, :update, :destroy]

  # GET /messages
  # def index
  #   @messages = Message.all

  #   render json: @messages
  # end

  # GET /messages/:application_id/:number
  def index
    @message = Message.where(chat_id: @chat[:id]).as_json(:except=> [:id, :chat_id])
    render json: @message
  end

  # GET /messages/search?keyword=val
  def search
    begin
      @messages = Message.chat_search(params[:keyword], @chat[:id])
    rescue StandardError
      render :json => []
    else
      render json: @messages.as_json(:except => [:id, :chat_id])
    end
  end


  # def search
  #   @message = Message.search_(query: params[:content])
  #   render json: @messages.as_json
  #   # begin
      
  #   # rescue StandardError
  #   #   render :json => StandardError
  #   # else
      
  #   # end
  # end


  # POST /messages
  def create
    # @message = Message.new(chat_id: @chat[:id], content: params[:content], number:  params[:number])

    publisher = PublishHandler.new
    publisher.send_message($messageQueue, 
                {chat_id: @chat[:id], content: params[:content], number:  params[:number]})

    redis_handler = RedisHandler.new
    @messages_number = redis_handler.incr_key(@chat[:id])
              
    render json:{"number of messages": @messages_number}, status: :created

   
  end

  # # PATCH/PUT /messages/1
  # def update
  #   if @message.update(message_params)
  #     render json: @message
  #   else
  #     render json: @message.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /messages/1
  # def destroy
  #   @message.destroy
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      params.require(:message).permit(:content, :chat_id, :number)
    end

    def app_chat_id
      @application_chat = Application.where(token: params[:application_id]).first
      @chat = Chat.where(application_id: @application_chat[:id],number: params[:chat_id].to_i).first
    end
    
end
