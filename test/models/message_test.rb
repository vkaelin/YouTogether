require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  test 'valid case' do
    message = Message.new content: 'Amazing content', user: User.new, room: Room.new
    assert message.valid?
  end

  test 'presence of url' do
    message = Message.new user: User.new, room: Room.new
    refute message.valid?
  end

  test 'blank url' do
    message = Message.new content: '', user: User.new, room: Room.new
    refute message.valid?
  end

  test 'most recent returns good number' do
    50.times do |i|
      message = Message.create(content: "Random message #{i+1}", user: User.new(email:'random@epfl.ch'), room: Room.new)
      message.save!
    end

    assert_equal 25, Message.most_recent(25).length
    assert_equal 50, Message.most_recent(50).length
    assert_equal 50, Message.most_recent(55).length
  end

  test 'last message is last in most recent' do
    50.times do |i|
      message = Message.create(content: "Random message #{i+1}", user: User.new(email:'random@epfl.ch'), room: Room.new)
      message.save!
    end

    assert_equal 'Random message 50', Message.most_recent(10).last.content
  end
end
