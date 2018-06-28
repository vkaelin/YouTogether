require "application_system_test_case"

class RoomsTest < ApplicationSystemTestCase
  test 'create new room' do
    user = User.new email: 'test@epfl.ch', name: 'Test', password: 'password'
    user.save!

    visit(login_path({ locale: 'en' }))
    fill_in('Email', with: user.email)
    fill_in('password', with: user.password)
    click_button('Log in')

    visit(new_room_path({ locale: 'en' }))
    fill_in('Name', with: 'Amazing room')
    click_button('Create room')
    assert page.has_content?('Amazing room')
  end

  test 'index loads the rooms' do
    room_1 = Room.new name: 'First room', user: User.new(email: 'test@epfl.ch')
    room_1.save!

    room_2 = Room.new name: 'Second room', user: User.new(email: 'test@epfl.ch')
    room_2.save!

    visit(rooms_path({ locale: 'en' }))
    assert page.has_content?('First room')
    assert page.has_content?('Second room')
  end

  test 'search' do
    room_1 = Room.new name: 'First room', user: User.new(email: 'test@epfl.ch')
    room_1.save!

    room_2 = Room.new name: 'Second room', user: User.new(email: 'test@epfl.ch')
    room_2.save!

    visit(rooms_path({ locale: 'en' }))
    fill_in('q', with: 'First')
    click_on('Search', match: :first)
    assert page.has_content?('First room')
    refute page.has_content?('Second room')
  end

  test 'no search results' do
    room_1 = Room.new name: 'First room', user: User.new(email: 'test@epfl.ch')
    room_1.save!

    visit(rooms_path({ locale: 'en' }))
    fill_in('q', with: 'Random search')
    click_on('Search', match: :first)
    refute page.has_content?('First room')
    assert page.has_content?('No rooms found!')
  end

  test 'rooms pagination by 9' do
    10.times do |i|
      room = Room.new
      room.name = "Example Room #{i+1}"
      room.user = User.new(email: 'test@epfl.ch')
      room.save!
    end

    visit(rooms_path({ locale: 'en' }))
    assert page.has_content?('Example Room 1')
    assert page.has_content?('Example Room 2')
    assert page.has_content?('Example Room 9')
    refute page.has_content?('Example Room 10')
  end

  test 'new room with a too long name' do
    user = User.new email: 'test@epfl.ch', name: 'Test', password: 'password'
    user.save!

    visit(login_path({ locale: 'en' }))
    fill_in('Email', with: user.email)
    fill_in('Password', with: user.password)
    click_button('Log in')

    visit(new_room_path({ locale: 'en' }))
    fill_in('Name', with: 'This is a too much long name for a Room')
    click_on('Create room')
    assert page.has_content?('Name is too long')
  end

  test 'see delete button if we are the owner of the room' do
    user = User.new email: 'test@epfl.ch', name: 'Test', password: 'password'
    user.save!

    room_1 = Room.new name: 'First room', user: user
    room_1.save!

    visit(login_path({ locale: 'en' }))
    fill_in('Email', with: user.email)
    fill_in('Password', with: user.password)
    click_button('Log in')

    visit(rooms_path({ locale: 'en' }))
    assert page.has_content?('DELETE ROOM')
    refute page.has_content?('JOIN')
  end

  test 'see join button if we dont are the owner of the room' do
    user_1 = User.new email: 'first@epfl.ch', name: 'First', password: 'password'
    user_1.save!

    user_2 = User.new email: 'second@epfl.ch', name: 'Second', password: 'password'
    user_2.save!

    room_1 = Room.new name: 'First room', user: user_1
    room_1.save!

    visit(login_path({ locale: 'en' }))
    fill_in('Email', with: user_2.email)
    fill_in('Password', with: user_2.password)
    click_button('Log in')

    visit(rooms_path({ locale: 'en' }))
    refute page.has_content?('DELETE ROOM')
    assert page.has_content?('JOIN')
  end

  test 'see all 3 buttons if we are an admin' do
    admin = User.new email: 'admin@epfl.ch', name: 'First', password: 'password', role: 'admin'
    admin.save!

    user_2 = User.new email: 'second@epfl.ch', name: 'Second', password: 'password'
    user_2.save!

    room_1 = Room.new name: 'First room', user: user_2
    room_1.save!

    visit(login_path({ locale: 'en' }))
    fill_in('Email', with: admin.email)
    fill_in('Password', with: admin.password)
    click_button('Log in')

    visit(rooms_path({ locale: 'en' }))
    assert page.has_content?('DELETE')
    assert page.has_content?('JOIN')
    assert page.has_content?('LEAVE')
  end

  test 'cannot join room if not logged' do
    room_1 = Room.new name: 'First room', user: User.new(email: 'test@epfl.ch')
    room_1.save!

    visit(rooms_path({ locale: 'en' }))
    click_on('Join')
    assert_equal current_path, login_path({ locale: 'en' })
  end

  test 'cannot display room if not joined' do
    user_1 = User.new email: 'first@epfl.ch', name: 'First', password: 'password'
    user_1.save!

    user_2 = User.new email: 'second@epfl.ch', name: 'Second', password: 'password'
    user_2.save!

    room_1 = Room.new name: 'First room', user: user_1
    room_1.save!

    visit(login_path({ locale: 'en' }))
    fill_in('Email', with: user_2.email)
    fill_in('Password', with: user_2.password)
    click_button('Log in')

    visit(room_path(room_1, { locale: 'en' }))
    assert_equal current_path, rooms_path({ locale: 'en' })
  end

  test 'joining a room' do
    user = User.new email: 'test@epfl.ch', name: 'Test', password: 'password'
    user.save!

    room_1 = Room.new name: 'First room', user: User.new(email: 'owner@epfl.ch')
    room_1.save!

    visit(login_path({ locale: 'en' }))
    fill_in('Email', with: user.email)
    fill_in('Password', with: user.password)
    click_button('Log in')

    visit(rooms_path({ locale: 'en' }))
    click_on('Join')
    assert page.has_content?('First room')
    assert_equal current_path, room_path(room_1, { locale: 'en' })
  end
end
