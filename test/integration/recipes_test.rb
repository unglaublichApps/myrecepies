require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest

  def setup
    @user = Chef.create(chefname: "Peter", email: "peter@ahoj.com")
    @recipe = Recipe.create(name: "vegetable saute", description: "greate vegetable", chef: @user)
    @recipe2 = @user.recipes.build(name: "chicken saute", description: "greate chicken dish")
    @recipe2.save
  end

  test "should get recipes index" do
    get recipes_url
    assert_response :success
  end

  test "should get recipes listing" do
    get recipes_url
    assert_template 'recipes/index'
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body
  end

end
