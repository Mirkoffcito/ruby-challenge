class MoviesRepresenter
    def initialize(movies)
        @movies = movies
    end

    def as_json
        @movies.map do |movie|
            {
                movie_id: movie.id,
                movie_title: movie.title,
                image: movie.image_url,
            }
        end
    end

    private
    attr_reader :movies
end