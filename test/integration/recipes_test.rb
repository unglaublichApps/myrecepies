require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest

  def setup
    @user = Chef.create(chefname: "Peter", email: "peter@ahoj.com",
        password: "password", password_confirmation: "password")
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
    assert_select "a[href=?]", recipes_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipes_path(@recipe2), text: @recipe2.name
  end

  test "should get recipes show" do
    get recipes_path(@recipe)
    assert_template 'recipes/show'
    assert_match @recipe.name, response.body
    assert_match @recipe.description, response.body
    assert_match @user.chefname, response.body
    assert_select 'a[href=?]', edit_recipe_path(@recipe), text:'Edit'
    assert_select 'a[href=?]', recipe_path(@recipe), text:'Delete this recipe'
    assert_select 'a[href=?]', recipes_path(@recipe), text:'Return to recipes listing'
  end

  test "create new valid recipe" do
    get new_recipe_path
    assert_template 'recipes/new'
    name_of_recipe = "chicken saute"
    description_of_recipe = "add chicke, add vegetable, cook 20minutes"
    assert_difference 'Recipe.count' do
      post recipes_path, params: {recipe: { name: name_of_recipe, description: description_of_recipe } }
    end
    follow_redirect!
    assert_match name_of_recipe.capitalize, response.body
    assert_match description_of_recipe, response.body
  end

  test "recet invalid recipe submissions" do
    get new_recipe_path
    assert_template 'recipes/new'
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: { recipe: { name: " ", description: " "} }
    end
    assert_template 'recipes/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

end
