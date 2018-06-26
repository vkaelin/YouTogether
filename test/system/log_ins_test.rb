require "application_system_test_case"


class LogInsTest < ApplicationSystemTestCase

  test 'sign up creates a User' do
    visit(signup_path)
    fill_in('Email', with: 'valentin@epfl.ch')
    fill_in('Password', with: 'password')
    click_on('Sign up', match: :first)

    assert_equal 1, User.all.length
    assert_equal 'valentin@epfl.ch', User.first.email
  end

  test 'log in does not create a User' do
    user = User.new email: 'valentin@epfl.ch', name: 'Valentin', password: 'password'
    user.save
    visit(login_path)
    fill_in('Email', with: user.email)
    fill_in('Password', with: user.password)
    click_on('Log in', match: :first)

    assert_equal 1, User.all.length
  end
end
