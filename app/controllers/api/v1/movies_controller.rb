class Api::V1::MoviesController < ApplicationController
    #before_action :authenticate_user, only: [:create, :update, :destroy]
    before_action :get_studio
    before_action :set_movie, only: [:show, :update, :destroy]
    before_action :order_params

    has_scope :by_title # search by title -> /api/v1/studios/1/movies?title=tituloDeLaPeli
    has_scope :by_genre
    
    # GET /studios/:studio_id/movies
    def index
        @movies = apply_scopes(Movie.where(studio_id:@studio.id)).order(created_at: @order)
        render json: MoviesRepresenter.new(@movies).as_json
    end

    def show
        render json: MovieRepresenter.new(@movie).as_json
    end

    # POST /studios/:studio_id/movies
    def create
        @movie = Movie.new(movie_params)
    
        if @movie.save
          render json: MovieRepresenter.new(@movie).as_json, status: :created
        else
          render json: @movie.errors, status: :unprocessable_entity
        end
    end


    # PATCH/PUT /studios/1
    def update
        if @movie.update(movie_params)
            render json: MovieRepresenter.new(@movie).as_json
        else
            render json: @movie.errors, status: :unprocessable_entity
        end
    end


    private

    def get_studio
        @studio = Studio.find(params[:studio_id])
    end

    def set_movie
        @movie = Movie.where(studio_id:@studio.id).find(params[:id])
    end

    def movie_params
        params.permit(:title, :date_released, :score, :image, {:character_ids => []}, {:genre_ids => []}).merge(studio_id: @studio.id,)
    end

    def order_params
        @order = params.fetch(:order, "asc")  # Captura el parametro ASC o DESC pasado en la URL, si no se pasa ningún parametro, setea ASC por default.
    end
end