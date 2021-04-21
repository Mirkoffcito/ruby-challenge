class SeriesRepresenter
    def initialize(series)
        @series = series
    end

    def as_json
        @series.map do |serie|
            {
                serie_id: serie.id,
                title: serie.title,
                seasons: serie.seasons,
                image: serie.image_url,
            }
        end
    end

    private
    attr_reader :series
end