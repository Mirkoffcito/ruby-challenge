class Api::V1::StudiosController < ApplicationController
    #authenticate_user, only: [:create, :update, :destroy] significa que sólo necesito estar autenticado
    #para realizar un post, un put o un delete de un registro, pero al 
    #realizar un GET (api/v1/studios) no necesito estar autenticado
    before_action :authenticate_user, only: [:create, :update, :destroy]
    before_action :set_studio, only: [:show, :update, :destroy] # Setea el estudio acorde al parametro que le pasamos en la url (studios/:studio_id)
    
    has_scope :by_name

    # GET /studios
    def index
        #utilizamos (limit) y offset para la paginación. limit establece el límite
        #de elementos por página (y tiene un valor default si no se le da uno)
        #y offset es "la página", por ej: api/v1/studios?limit=2&offset=1
        # el límite de elementos por página es dos, y voy a la página 1 (empieza en 0)
        @studios = apply_scopes(Studio.limit(limit).offset(params[:offset]))
    
        render json: StudiosRepresenter.new(@studios).as_json
    end

    # GET /studios/1
    def show
        render json: StudioRepresenter.new(@studio).as_json
    end

    def create
        @studio = Studio.new(studio_params)
    
        if @studio.save
          render json: StudioRepresenter.new(@studio).as_json
        else
          render json: @studio.errors, status: :unprocessable_entity
        end
    end

    # PATCH/PUT /studios/1
    def update
        if @studio.update(studio_params)
            render json: StudioRepresenter.new(@studio).as_json
        else
            render json: @studio.errors, status: :unprocessable_entity
        end
    end

    # DELETE /studios/1
    def destroy
     @studio.destroy
    end


    private

      def limit
        [
          params.fetch(:limit, 3).to_i, # if there is no limit, default is 3, default minimum(if no limit is given) is 3
          3
        ].min
      end
      # Use callbacks to share common setup or constraints between actions.
      def set_studio
        @studio = Studio.find(params[:id]) 
      end
  
      # Only allow a list of trusted parameters through.
      def studio_params
        params.permit(:name, :image)
      end
end