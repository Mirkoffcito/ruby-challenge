class Genre < ApplicationRecord
    has_and_belongs_to_many :movies
    has_and_belongs_to_many :seriees
    
    validates :name, presence: true, uniqueness: true

    scope :by_name, -> name {where("name LIKE ?", "%" + name + "%")}
end
