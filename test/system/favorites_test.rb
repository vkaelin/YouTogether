require "application_system_test_case"

class FavoritesTest < ApplicationSystemTestCase
  test 'add a favorite video' do
    user = User.new email: 'test@epfl.ch', name: 'Test', password: 'password'
    user.save!

    visit(login_path({ locale: 'en' }))
    fill_in('Email', with: user.email)
    fill_in('password', with: user.password)
    click_button('Log in')

    visit(account_path({ locale: 'en' }))
    click_on('Add a favorite video')
    fill_in('Url', with: 'https://www.youtube.com/watch?v=m3YX8zlR4BU')
    click_button('Add')
    assert page.has_selector?('.video-link')
    assert_equal current_path, account_path({ locale: 'en' })
  end

  test 'remove a favorite video' do
    user = User.new email: 'test@epfl.ch', name: 'Test', password: 'password'
    user.save!

    visit(login_path({ locale: 'en' }))
    fill_in('Email', with: user.email)
    fill_in('password', with: user.password)
    click_button('Log in')

    visit(account_path({ locale: 'en' }))
    click_on('Add a favorite video')
    fill_in('Url', with: 'https://www.youtube.com/watch?v=m3YX8zlR4BU')
    click_button('Add')

    assert page.has_selector?('.video-link')
    click_on(class: 'delete-video')
    visit(account_path({ locale: 'en' }))
    refute page.has_selector?('.video-link')
  end

end
