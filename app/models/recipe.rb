class Recipe < ApplicationRecord

  #association
  belongs_to :chef
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :comments, dependent: :destroy

  #validation
  validates :chef_id, presence: true
  validates :name, presence: true
  validates :description, presence: true, length: {minimum: 5, maximum: 500}

  default_scope -> { order(updated_at: :desc) }

end
