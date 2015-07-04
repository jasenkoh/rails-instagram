require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should follow and unfollow a user' do
    jasenko = users(:jasenko)
    amela = users(:amela)
    assert_not jasenko.following?(amela)
    jasenko.follow(amela)
    assert jasenko.following?(amela)
    assert amela.followers.include?(jasenko)
    jasenko.unfollow(amela)
    assert_not jasenko.following?(amela)
  end
end
