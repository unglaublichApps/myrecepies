require 'test_helper'

class ChefTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new(chefname: "Peter", email: "peter.risko@gmail.com", password: "password", password_confirmation: "password")
  end

  test "should be valid" do
    assert @chef.valid?
  end

  test "name should be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end

  test "name should be less than 30 characters" do
    @chef.chefname = "a" * 31
    assert_not @chef.valid?
  end

  test "email should be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end

  test "should reject invalid address" do
    invalid_emails = %w[peter@example peter@example,com peter.dino@gmail peter+dino.com]
    invalid_emails.each do |invalids|
      @chef.email = invalid_emails
      assert_not @chef.valid? "#{invalids.inspect} should be valid"
    end
  end

  test "email should not be too long" do
    @chef.email = "a" * 245 + "@example.com"
    assert_not @chef.valid?
  end

  test "email should be valid format" do
    valid_emails = %w[user@example.com Peter@gmail.com M.first@yahoo.ca john+smith@co.uk.org]
    valid_emails.each do |valids|
      @chef.email = valids
      assert @chef.valid?, "#{valids.inspect} should be valid"
    end
  end

  test "email should be unique and case insensitive" do
    duplicate_chef = @chef.dup
    duplicate_chef.email = @chef.email.upcase
    @chef.save
    assert_not duplicate_chef.valid?
  end

  test "email should be lower case before hitting db" do
    mixed_email = "PeTeR@Example.com"
    @chef.email = mixed_email
    @chef.save
    assert_equal mixed_email.downcase, @chef.reload.email
  end

  test "password should be pwesent" do
    @chef.password = @chef .password_confirmation = " "
    assert_not @chef.valid?
  end

  test "password should be atleast 5 characters" do
    @chef.password = @chef .password_confirmation = "x" * 4
    assert_not @chef.valid?
  end

end
