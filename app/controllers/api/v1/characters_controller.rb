class Api::V1::CharactersController < ApplicationController
    #before_action :authenticate_user, only: [:create, :update, :destroy]
    before_action :get_studio
    before_action :set_character, only: [:show, :update, :destroy]
    before_action :order_params

    # permite buscar personajes de un estudio por nombre
    #por ejemplo: localhost:3000/api/v1/studios/1/characters=name='Simba' -> devuelve el personaje Simba
    has_scope :by_name 

    
    # permite buscar por edad en un rango determinado, por ejemplo:
    # /api/v1/studios/1/characters=by_age[from]=1&by_age[to]=5 -> busca los personajes
    # de edad entre 1 y 5 (incluye a uno e incluye a 5, revisar configuracion en el modelo)
    has_scope :by_age, using: [:from, :to]
    has_scope :by_weight, using: [:from, :to]
    
    has_scope :by_movie

    # GET /characters
    def index
        @characters = (apply_scopes(Character.where(studio_id:@studio.id))).order(created_at: @order)

        render json: CharactersRepresenter.new(@characters).as_json
    end
    
    # GET /characters/1
    def show
        if @studio.id == @character.studio_id
            render json: CharacterRepresenter.new(@character).as_json
        else
            render json: @character.errors, status: :not_acceptable
        end
    end

    # POST /characters
    def create
        @character = Character.new(character_params)
    
        if @character.save
            render json: CharacterRepresenter.new(@character).as_json
        else
            render json: @character.errors, status: :unprocessable_entity
        end
    end

    # PATCH/PUT /characters/1
    def update
        if @character.update(character_params)
            render json: CharacterRepresenter.new(@character).as_json
        else
            render json: @character.errors, status: :unprocessable_entity
        end
    end

    # DELETE /characters/1
    def destroy
        @character.destroy
    end

    private

    def get_studio
        @studio = Studio.find(params[:studio_id])
    end

    def set_character
        @character = Character.find(params[:id])
    end

    def character_params
        params.permit(:name, :age, :weight_kg, :history, :image, {:movie_ids => []}, {:seriee_ids =>[]}).merge(studio_id: @studio.id)
    end

    def order_params
        @order = params.fetch(:order, "asc")  # Captura el parametro ASC o DESC pasado en la URL, si no se pasa ningún parametro, setea ASC por default.
    end
      
end