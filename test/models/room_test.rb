require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  attr_accessor :current_user
  include RolesHelper

  test 'the first Room created is first in the list' do
    room_1 = Room.create name: 'First room', owner: User.new(email:'random@epfl.ch')
    room_2 = Room.create name: 'Second room', owner: User.new(email:'random@epfl.ch')
    assert_equal(room_1, Room.all.first)
  end

  test 'the last Room created is last in the list' do
    room_1 = Room.create name: 'First room', owner: User.new(email:'random@epfl.ch')
    room_2 = Room.create name: 'Second room', owner: User.new(email:'random@epfl.ch')
    assert_equal(room_2, Room.all.last)
  end

  test 'presence of name' do
    room = Room.new owner: User.new(email:'random@epfl.ch')
    refute room.valid?
  end

  test 'length of name' do
    room = Room.create name: 'This is a too long name for a room', owner: User.new(email:'random@epfl.ch')
    refute room.valid?
  end

  test 'search no result' do
    room_1 = Room.create name: 'First room', owner: User.new(email:'random@epfl.ch')
    room_2 = Room.create name: 'Second room', owner: User.new(email:'random@epfl.ch')

    results = Room.search('yolo')
    assert_empty results
  end

  test 'search with one result' do
    room_1 = Room.create name: 'First room', owner: User.new(email:'random@epfl.ch')
    room_2 = Room.create name: 'Second room', owner: User.new(email:'random@epfl.ch')

    results = Room.search('First')
    assert_equal 1, results.length
  end

  test 'search with two results' do
    room_1 = Room.create name: 'First room', owner: User.new(email:'random@epfl.ch')
    room_2 = Room.create name: 'Second room', owner: User.new(email:'random@epfl.ch')

    results = Room.search('room')
    assert_equal 2, results.length
  end

  test 'room can be deleted by owner' do
    owner = User.create(email: 'owner@epfl.ch', password: 'password')
    self.current_user = owner
    room = Room.create(name: 'A test room', owner: owner)
    assert can_delete_room?(room)
  end

  test 'room can be deleted by an admin' do
    admin = User.create(email: 'admin@epfl.ch', password: 'password', role: 'admin')
    self.current_user = admin

    owner = User.create(email: 'owner@epfl.ch', password: 'password')
    room = Room.create(name: 'A test room', owner: owner)
    assert can_delete_room?(room)
  end

  test 'room cannot by deleted by another user' do
    other = User.create(email: 'other@epfl.ch', password: 'password')
    self.current_user = other

    owner = User.create(email: 'owner@epfl.ch', password: 'password')
    room = Room.create(name: 'A test room', owner: owner)
    refute can_delete_room?(room)
  end
end
