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
                    {
                    movie_id: movie.id,
                    movie_title: movie.title,
                    movie_image: movie.image_url
                }
                end
            end,
            genre_series:
            begin
                genre.seriees.map do |serie|
                    {
                    serie_id: serie.id,
                    serie_title: serie.title,
                    serie_image: serie.image_url
                }
                end
            end
        }
    end
    private
    attr_reader :genre
end