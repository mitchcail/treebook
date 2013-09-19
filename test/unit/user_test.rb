require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should have_many(:user_friendships)
  should have_many(:friends)
  
  test "a user needs to enter a first name" do
  	#user should not be saved in the database without filling out all 
  	#the required areas in the form
  	user = User.new
  	assert !user.save
  	assert !user.errors[:first_name].empty?
  end

  test "a user needs to enter a last name" do
  	#user should not be saved in the database without filling out all 
  	#the required areas in the form
  	user = User.new
  	assert !user.save
  	assert !user.errors[:last_name].empty?
  end

  test "a user needs to enter a profile name" do
  	#user should not be saved in the database without filling out all 
  	#the required areas in the form
  	user = User.new
  	assert !user.save
  	assert !user.errors[:profile_name].empty?	
  end

  test "a user should have a unique profile name" do
  	user = User.new
  	user.profile_name = users(:mitch).profile_name
  	user.first_name = 'mitch'
  	user.last_name = 'cail'
  	user.email = 'mcail@somehwere.com'
  	user.password = 'password'
  	user.password_confirmation = 'password'

  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  end

  test "a user should have a profile name without spaces" do
  	user = User.new
  	user.profile_name = "Profile name with spaces"
  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  	assert user.errors[:profile_name].include?("must be formatted correctly. no spaces aloud.")

  end

  test "a user can have a correctly formatted profile name" do
    user = User.new
    user.first_name = 'mitch'
    user.last_name = 'cail'
    user.email = 'mcail@somehwere.com'
    user.password = user.password_confirmation = 'asdfasd'
    user.profile_name = 'ballsohard'
    assert user.valid?
  end

  test "no error is raised when trying to access a users friends" do
    assert_nothing_raised do
      users(:mitch).friends
    end
  end

  test "that users are able to create friendships" do
    users(:mitch).friends << users(:cali)
    users(:mitch).friends.reload
    assert users(:mitch).friends.include?(users(:cali))
  end


end
