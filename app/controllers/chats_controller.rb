require 'redis_handler'
class ChatsController < ApplicationController
  before_action :app_id
  before_action :set_chat, only: [:show, :update]
  # before_action :set_chats_number, only: [:create]

  # GET /chats/:application_id
  def index
    ######################################################
    ########### return all except id, application_id #####
    ######################################################
    print @application_chat
    @chats = Chat.where(application_id: @application_chat[:id])

    render json: @chats
  end

  # GET /chats/token/number
  # GET /chats/08f9e12f43b0e1afb15a633dd9e4c2e2f68de91d/64
  def show
    render json: @chat
  end

  # POST /chats/
  def create
    @chat = Chat.new(number: params[:number], application_id: @application_chat[:id])
    ######################################################
    ######### return number of chats #####################
    ######################################################
    
  

    # content = {
    #   number: @chats_number,
    #   application_id: @application_chat[:id]
    # }
    # handler = PublishHandler.new
    # handler.send_message($chatQueueName, content)

  
    if @chat.save
      redis_handler = RedisHandler.new
      @chats_number = redis_handler.incr_key(@application_chat[:token])
    
      render json:{"number of chats": @chats_number}, status: :created
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # # PATCH/PUT /chats/1
  # def update
  #   if @chat.update(@chats)
  #     render json: @chat
  #   else
  #     render json: @chat.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /chats/1
  # def destroy
  #   @chat.destroy
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.where(number: params[:number], application_id: @application_chat[:id]).first
    end

    # def set_chats_number
    #   redis_handler = RedisHandler.new
    #   @chats_number = redis_handler.incr_key(@application_chat[:token].to_s)
    #   print @chats_number
    # end
    # Only allow a trusted parameter "white list" through.
    def chat_params
      params.require(:chat).permit(:number, :application_id)
    end

    def app_id
      print params
      @application_chat = Application.where(token: params[:application_id]).first
    end
end
