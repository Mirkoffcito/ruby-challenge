class GenreRepresenter
    def initialize(genre)
        @genre = genre
    end

    def as_json
        {
            id: genre.id,
            name: genre.name,
            genre_movies:
            begin
                genre.movies.map do |movie|
                    movie.title
                end
            end,
            genre_series:
            begin
                genre.seriees.map do |serie|
                    serie.title
                end
            end
        }
    end
    private
    attr_reader :genre
end