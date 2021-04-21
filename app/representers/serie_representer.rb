class SerieRepresenter 
    def initialize(serie)
        @serie = serie
    end

    def as_json
        {
            id: serie.id,
            title: serie.title,
            date_released: serie.date_released,
            score: serie.score,
            studio: serie.studio.name,
            image: serie.image_url,
            characters:
            begin
                serie.characters.map do |character|
                    character.name
                end
            end,
            genres:
            begin
                serie.genres.map do |genre|
                    genre.name
                end
            end  
        }
    end

    private
    attr_reader :serie
end