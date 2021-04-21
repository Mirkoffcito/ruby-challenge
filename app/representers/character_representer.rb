class CharacterRepresenter
    def initialize(character)
        @character = character
    end

    def as_json
        {
            id: character.id,
            studio: character.studio.name,
            name: character.name,
            age: character.age,
            weight_kg: character.weight_kg,
            history: character.history,
            image: character.image_url,
            movies:
            begin
                character.movies.map do |movie|
                    movie.title
                end
            end,
            series:
            begin
                character.seriees.map do |serie|
                    serie.title
                end
            end
        }
    end

    private
    attr_reader :character
end