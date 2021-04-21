class StudioRepresenter
    def initialize(studio)
        @studio = studio
    end

    def as_json
            {
                id: @studio.id,
                name: @studio.name,
                image: @studio.image_url,
                movies: 
                begin
                    @studio.movies.map do |movie|
                        {
                          movie: movie.title,
                          image:  movie.image_url,
                        }
                    end
                end,
                series:
                begin
                    @studio.seriees.map do |serie|
                        {
                          serie: serie.title,
                          image:  serie.image_url,
                        }
                    end
                end,
                characters:
                begin
                    @studio.characters.map do |character|
                        {
                          name: character.name,
                          image:  character.image_url,
                        }
                    end
                end
            }
    end
       
    private
    attr_reader :studios
end