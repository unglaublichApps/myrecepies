class RecipeIngredient < ApplicationRecord

  #association
  belongs_to :ingredient
  belongs_to :recipe

end
