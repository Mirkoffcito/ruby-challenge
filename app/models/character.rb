class Character < ApplicationRecord
  belongs_to :studio
  
  has_and_belongs_to_many :movies
  has_and_belongs_to_many :seriees

  include ImageUploader::Attachment(:image)

  scope :by_name, -> name {where(name: name)}
  scope :by_age, -> from, to { where("age >= ? AND age <= ?", from, to) }
  scope :by_weight, -> from, to { where("weight_kg >= ? AND weight_kg <= ?", from, to) }
  scope :by_movie, -> id {where(:movie_ids => id)}

  scope :by_movie, -> movies {    # supongamos que queremos buscar personajes por las películas en las que aparecen
    movies_array = (movies.split(',')).map(&:to_i) # enviamos dichos parametros characters/?by_movie=1
    joins(:movies).where(movies: movies_array)
  }

end
