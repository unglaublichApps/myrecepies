require 'test_helper'

class ChefShowTest < ActionDispatch::IntegrationTest

  def setup
    @user = Chef.create(chefname: "Peter", email: "peter@ahoj.com",
        password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "vegetable saute", description: "greate vegetable", chef: @user)
    @recipe2 = @user.recipes.build(name: "chicken saute", description: "greate chicken dish")
    @recipe2.save
  end

  test "should get chef show " do
    get chef_path(@chef)
    assert_template 'chef/show'
    assert_select "a[href=?]", recipes_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipes_path(@recipe2), text: @recipe2.name
    assert_match @recipe.description, response.body
    assert_match @recipe2.description, response.body
    assert_match @chef.chefname, response.body

  end

end
