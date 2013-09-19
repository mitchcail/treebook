require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  
  should belong_to(:user)
  should belong_to(:friend)

  test "a user friendship without raising an exception" do
  	assert_nothing_raised do 
  		UserFriendship.create user: users(:mitch), friend: users(:cali)
  	end
  end

  test "that creating a friendship based on a user id and friend id works" do 
  	UserFriendship.create user_id: users(:mitch).id, friend_id: users(:cali).id
  	assert users(:mitch).friends.include?(users(:cali))

  end
end
