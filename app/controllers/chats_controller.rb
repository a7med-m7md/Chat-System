require 'redis_handler'
require 'publisher'

class ChatsController < ApplicationController
  before_action :app_id
  before_action :set_chat, only: [:show, :update]

  # GET /chats/
  def index
    ######################################################
    ########### return all except id, application_id #####
    ######################################################
    @chats = Chat.where(application_id: @application_chat[:id])
    render json: @chats.as_json(:except => [:id, :application_id])
  end

  # GET /chats/token/number
  # GET /chats/08f9e12f43b0e1afb15a633dd9e4c2e2f68de91d/64
  def show
    render json: @chat.as_json(:except => [:id, :application_id])
  end

  # POST /chats/
  def create
    # @chat = Chat.new(number: params[:number], application_id: @application_chat[:id])

    publisher = PublishHandler.new
    publisher.send_message(
      $chatQueue, {number: params[:number], application_id: @application_chat[:id]}
    )
    redis_handler = RedisHandler.new
    @chats_number = redis_handler.incr_key(@application_chat[:token])
  
    render json:{"number of chats": @chats_number}, status: :created
  end


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
      # print params
      @application_chat = Application.where(token: params[:application_id]).first
    end
end
