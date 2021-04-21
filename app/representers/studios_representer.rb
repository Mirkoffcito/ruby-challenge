class StudiosRepresenter
    def initialize(studios)
        @studios = studios
    end

    def as_json
        @studios.map do |studio|
            {
                id: studio.id,
                name: studio.name,
                image: studio.image_url,
            }
        end
    end
       
    private
    attr_reader :studios
end