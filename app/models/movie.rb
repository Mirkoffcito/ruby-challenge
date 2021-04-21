class Movie < ApplicationRecord
  belongs_to :studio
  
  has_and_belongs_to_many :characters
  has_and_belongs_to_many :genres

  validates :title, presence: true, uniqueness: {scope: :studio_id} # Verifica que el titulo de la pelicula sea unico solamente si son del mismo estudio
  validates :date_released, presence: true
  validates :score, presence: true
  validates :studio_id, presence: true

  include ImageUploader::Attachment(:image)

  scope :by_title, -> title {where(title: title)}

end
