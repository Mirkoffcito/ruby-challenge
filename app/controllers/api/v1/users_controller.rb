class Api::V1::UsersController < ApplicationController
    #sera necesario estar autenticado para utilizar cualquiera de los métodos
    #excepto para crear un nuevo usuario
    #Para estar autenticado, deberemos pasar cómo parametro el token jwt, mediante un bearer.
    before_action :authenticate_user, except: [:create]
    before_action :set_user, only: [:show, :destroy] # sólo ejecuta set_user antes de realizar show o destroy
  
    # GET /users
    def index
      if current_user # para acceder acá, debo haberle pasado el token vía header, con Content type -> app/json y Authorization->Bearer token
        render json: UserRepresenter.new(current_user).as_json
      else
        render json: "NO SE ENCUENTRA AUTENTICADO"
      end
    end
  
    # GET /users/1
    def show
      if current_user.id==@user.id # para acceder acá, debo haberle pasado el token vía header, con Content type -> app/json y Authorization->Bearer token
        render json: UserRepresenter.new(current_user).as_json
      else
        render json: "NO SE ENCUENTRA AUTENTICADO"
      end
    end
  
    # POST /users
    def create
      @user = User.new(user_params)
  
      if @user.save
        render json: @user, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /users/1
    def destroy
      if @user.id==current_user.id
        @user.destroy
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def user_params
        params.permit(:username, :password, :password_confirmation)
      end
  end