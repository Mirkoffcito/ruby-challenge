class Studio < ApplicationRecord
    has_many :movies, dependent: :destroy
    has_many :characters, dependent: :destroy
    has_many :seriees, dependent: :destroy

    validates :name, presence: true, uniqueness: true

    include ImageUploader::Attachment(:image)
    
    scope :by_name, -> name {where(name: name)}
end
