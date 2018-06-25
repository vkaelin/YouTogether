require 'test_helper'

class FavoriteVideoTest < ActiveSupport::TestCase
  attr_accessor :current_user
  include RolesHelper

  test 'valid case' do
    favorite = FavoriteVideo.new url: 'some url', user: User.new
    assert favorite.valid?
  end

  test 'presence of url' do
    favorite = FavoriteVideo.new user: User.new
    refute favorite.valid?
  end

  test 'blank url' do
    favorite = FavoriteVideo.new url: '', user: User.new
    refute favorite.valid?
  end

  test 'favorite can be deleted by owner' do
    owner = User.create(email: 'owner@epfl.ch', password: 'password')
    self.current_user = owner
    favorite = FavoriteVideo.create(url: 'Random url', user: owner)
    assert can_delete_fav?(favorite)
  end

  test 'favorite can be deleted by an admin' do
    admin = User.create(email: 'admin@epfl.ch', password: 'password', role: 'admin')
    self.current_user = admin

    owner = User.create(email: 'owner@epfl.ch', password: 'password')
    favorite = FavoriteVideo.create(url: 'Random url', user: owner)
    assert can_delete_fav?(favorite)
  end

  test 'favorite cannot by deleted by another user' do
    other = User.create(email: 'other@epfl.ch', password: 'password')
    self.current_user = other

    owner = User.create(email: 'owner@epfl.ch', password: 'password')
    favorite = FavoriteVideo.create(url: 'Random url', user: owner)
    refute can_delete_fav?(favorite)
  end
end
