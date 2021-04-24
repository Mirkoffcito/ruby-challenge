class Seriee < ApplicationRecord
  belongs_to :studio
  
  has_and_belongs_to_many :characters
  has_and_belongs_to_many :genres

  validates :title, presence: true, uniqueness: {scope: :studio_id} # Verifica que el titulo de la pelicula sea unico solamente si son del mismo estudio
  validates :date_released, presence: true
  validates :score, presence: true
  validates :studio_id, presence: true
  validates :image_data, presence: true
  validates :seasons, presence: true

  include ImageUploader::Attachment(:image)

  scope :by_title, -> title {where(title: title)}

  scope :by_genre, -> genres {    # supongamos que queremos buscar peliculas por genero aventura y fantasía (id 1 y 2)
    genre_array = (genres.split(',')).map(&:to_i) # enviamos dichos parametros movies/?by_genre=1,2 y genre.split(',') genera un arrray
    joins(:genres).where(genres: genre_array)  # "llama" a la tabla genres, para poder hacer un query sobre ella
  }

end
