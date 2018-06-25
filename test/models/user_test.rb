require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'email is lowercase before validation' do
    user = User.new email: 'nEw@EpFl.Ch', name: 'Random', password: 'password'
    assert user.valid?
    assert_equal user.email, 'new@epfl.ch'
  end

  test 'email is unique' do
    user_1 = User.create email: 'email@epfl.ch', name: 'Random', password: 'password'
    user_2 = User.new email: 'email@epfl.ch', name: 'Random 2', password: 'password'
    refute user_2.valid?
  end

  test 'name is needed' do
    user = User.new email: 'random“epfl.ch”', password: 'password'
    refute user.valid?
  end

  test 'password is needed' do
    user = User.new email: 'random“epfl.ch”', name: 'Random'
    refute user.valid?
  end

  test 'default role' do
    user = User.create(email: 'random@epfl.ch', name: 'Random', password: 'password')
    assert_equal user.role, 'registered'
  end

  test 'admin is a valid role' do
    user = User.create email: 'email@epfl.ch', name: 'Random', password: 'password', role: 'admin'
    assert user.valid?
  end

  test 'role not valid' do
    user = User.create email: 'email@epfl.ch', name: 'Random', password: 'password', role: 'strange_role'
    refute user.valid?
  end
end
