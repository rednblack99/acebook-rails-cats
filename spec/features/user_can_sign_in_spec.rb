RSpec.feature 'Sign in', type: :feature do
  scenario 'User successfully signs in' do
    fill_in_sign_up_details
    click_button 'Sign Up'
    visit '/'
    fill_in :sign_in_email, with: 'davethecat@katze.com'
    fill_in :sign_in_password, with: 'Gato123'
    click_button 'Sign In'
    expect(page.current_path).to eq('/posts')
  end

  scenario 'User gets notice when failing to sign in' do
    fill_in_sign_up_details
    click_button 'Sign Up'
    visit '/'
    fill_in :sign_in_email, with: 'davethecat@katze.com'
    fill_in :sign_in_password, with: 'Bananaman'
    click_button 'Sign In'
    expect(page.current_path).to eq('/')
    expect(page).to have_content("Email or password is invalid")
  end

  scenario 'User cannot access posts page without signing in' do
    visit '/posts'
    expect(page.current_path).to eq('/')
    expect(page).to have_content("Please sign in")
  end
end