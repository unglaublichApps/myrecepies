class Ingredient < ApplicationRecord

  #association
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  #validation
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates_uniqueness_of :name

end
