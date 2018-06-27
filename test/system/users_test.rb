require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  test 'edit profile' do
    user = User.new email: 'before@epfl.ch', name: 'Before', password: 'password'
    user.save!

    visit(login_path({ locale: 'en' }))
    fill_in('Email', with: user.email)
    fill_in('password', with: user.password)
    click_button('Log in')

    visit(account_path({ locale: 'en' }))
    fill_in('Email', with: 'after@epfl.ch')
    fill_in('Name', with: 'After')
    click_button('Update account')

    assert_equal current_path, account_path({ locale: 'en' })
    assert_equal 'After', page.find_field('Name').value
    assert_equal 'after@epfl.ch', page.find_field('Email').value
  end
end
