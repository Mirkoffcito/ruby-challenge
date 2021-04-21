class CharactersRepresenter
    def initialize(characters)
        @characters = characters
    end

    def as_json
        @characters.map do |character|
            {
                id: character.id,
                name: character.name,
                image: character.image_url,
            }
        end
    end

    private
    attr_reader :characters
end