require 'test_helper'

class RecipeEditTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create(chefname: "Peter", email: "peter@ahoj.com")
    @recipe = Recipe.create(name: "vegetable saute", description: "greate vegetable", chef: @user)
  end

  test "reject invalid recipe update" do
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe), params: { recipe: {name: " ", description: " dino" } }
    assert_template 'recipes/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "succesfully edit recipe" do
    get edit_recipe_path
    assert_template 'recipe/edit'
    updated_name = "updated recipe name"
    updated_description = "updated recipe description"
    patch recipe_path(@recipe), params:{ recipe: { name: updated_name, description: updated_description } }
    assert_redirect_to @recipe
    #follow_redirect!
    assert_not flash.empty?
    @recipe.reload
    assert_match updated_name, @recipe.name
    assert_match updated_description, @recipe.description
  end

end
