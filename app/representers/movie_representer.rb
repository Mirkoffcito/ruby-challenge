class MovieRepresenter 
    def initialize(movie)
        @movie = movie
    end

    def as_json
        {
            id: movie.id,
            title: movie.title,
            date_released: movie.date_released,
            score: movie.score,
            studio: movie.studio.name,
            image: movie.image_url,
            characters:
            begin
                movie.characters.map do |character|
                    character.name
                end
            end,
            genres:
            begin
                movie.genres.map do |genre|
                    genre.name
                end
            end  
        }
    end

    private
    attr_reader :movie
end