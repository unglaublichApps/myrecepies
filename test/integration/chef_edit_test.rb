require 'test_helper'

class ChefEditTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create(chefname: "Peter", email: "peter@ahoj.com",
        password: "password", password_confirmation: "password")
  end

  test "reject a invalid edit" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: { chefname: " ", email: "peter@gmail.com" } }
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "accept valid signup" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: { chefname: "peter1", email: "peter1@gmail.com"} }
    assert_redirect_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "peter1", @chef.chefname
    assert_match "peter1@gmail.com", @chef.email
  end

end
