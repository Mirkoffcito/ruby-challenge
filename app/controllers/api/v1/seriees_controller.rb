class Api::V1::SerieesController < ApplicationController
    #before_action :authenticate_user, only: [:create, :update, :destroy]
    before_action :get_studio
    before_action :set_serie, only: [:show, :update, :destroy]
    has_scope :by_title

    # GET /studios/:studio_id/seriees
    def index
        @series = apply_scopes(Seriee.where(studio_id:@studio.id))

        render json: SeriesRepresenter.new(@series).as_json
    end

    def show
        render json: SerieRepresenter.new(@serie).as_json
    end

    # POST /studios/:studio_id/seriees
    def create
        @serie = Seriee.new(serie_params)
    
        if @serie.save
          render json: SerieRepresenter.new(@serie).as_json, status: :created
        else
          render json: @serie.errors, status: :unprocessable_entity
        end
    end

    # PATCH/PUT /studios/1
    def update
        if @serie.update(serie_params)
            render json: SerieRepresenter.new(@serie).as_json
        else
            render json: @serie.errors, status: :unprocessable_entity
        end
    end

    # DELETE /studios/1/seriees/1
    def destroy
        @serie.destroy
    end

    private

    def get_studio
        @studio = Studio.find(params[:studio_id])
    end

    def set_serie
        @serie = Seriee.where(studio_id:@studio.id).find(params[:id]) # Si la serie que se busca en el GET es del studio, la va a devolver, sino, 404
    end

    def serie_params
        params.permit(:title, :date_released, :score, :image, :seasons, {:character_ids => []}, {:genre_ids => []}).merge(studio_id: @studio.id)
    end
end