class Api::V1::GenresController < ApplicationController
  before_action :authenticate_user, only: [:create, :update, :destroy]
  before_action :set_genre, only: [:destroy, :show, :update]

  has_scope :by_name

  # GET /genres
  def index
    @genres = apply_scopes(Genre.all)

    render json: GenresRepresenter.new(@genres).as_json
  end

  def show
    render json: GenreRepresenter.new(@genre).as_json
  end

  # POST /genres
  def create
    @genre = Genre.new(genre_params)

    if @genre.save
      render json: GenreRepresenter.new(@genre).as_json, status: :created
    else
      render json: @genre.errors, status: :unprocessable_entity
    end
  end

  # DELETE /genres/1
  def destroy
    @genre.destroy
  end

  # UPDATE /genres/1
  def update
    if @genre.update(genre_params)
        render json: GenreRepresenter.new(@genre).as_json
    else
        render json: @genre.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_genre
      @genre = Genre.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def genre_params
      params.permit(:name)
    end
end
