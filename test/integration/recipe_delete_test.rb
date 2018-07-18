require 'test_helper'

class RecipeDeleteTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create(chefname: "Peter", email: "peter@ahoj.com")
    @recipe = Recipe.create(name: "vegetable saute", description: "greate vegetable", chef: @user)
  end

  test " succes delete a recipe" do
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_select 'a[href=?]', recipe_path(@recipe), text: "Delete this recipe"
    assert_difference 'Recipe.count', -1 do
      delete recipe_path(@recipe)
    end
    assert_redirect_to recipes_path
    assert_not flash.empty?
  end

end
