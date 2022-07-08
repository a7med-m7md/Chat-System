class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :update]
  before_action :generate_token, only: [:create]
  
  # GET /applications
  # return all the application model content except id field
  def index
    @applications = Application.all.as_json(:except=> :id)
    render json: @applications
  end
  
  # GET /applications/:token
  # GET /applications/61c73fb3cec546e016b43ff6c05bafb5bf90cdce
  def show
    render json: @application.as_json(:except => :id)
  end

  # POST /applications
  # put the generated token and the name from request body 
  def create
    @application = Application.new(token: @random_token, name: params[:name])
    if @application.save
      render json: @application.as_json(:except => :id), status: :created, location: @application
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /applications/1
  def update
    if @application.update(name: params[:name])
      render json: @application.as_json(:except=> :id)
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      # @application = Application.find(params[:id])
      @application = Application.where(token: params[:id]).limit(1)[0]
    end

    # def set_app_token
    #   @app_token = Application.find(['token=?', params[:id]])
    # end
    # Only allow a trusted parameter "white list" through.
    def application_params
      params.require(:application).permit(:name)
    end

    
    def generate_token
      @random_token = Digest::SHA1.hexdigest([Time.now, rand(111..999)].join)
    end
end
