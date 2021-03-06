RSpec.feature 'Signup', type: :feature do
  context 'Successful signup' do
    scenario 'User provides valid details for all fields' do
      sign_up
      expect(page.current_path).to eq("/users/davethecat@katze.com")
    end
  end

  context 'Unsuccessful signup' do
    scenario 'User attempts signup with non unique email' do
      sign_up
      click_link 'Sign Out'
      sign_up
      expect(page.current_path).to eq('/users')
      expect(page).to have_content("Meow, email must be unique.")
    end

    scenario 'User attempts signup with email missing @' do
      fill_in_sign_up_details
      fill_in :email, with: 'davethecat1atkatze.com'
      click_button 'Sign Up'
      expect(page.current_path).to eq('/users')
      expect(page).to have_content("Meow, email must include @.")
    end

    scenario 'User cannot choose password shorter than 6 characters' do
      visit '/'
      fill_in_sign_up_details
      fill_in :password, with: 'plop'
      click_button 'Sign Up'
      expect(page.current_path).to eq('/users')
      expect(page).to have_content('is too short (minimum is 6 characters)')
    end

    scenario 'User cannot choose password longer than 10 characters' do
      fill_in_sign_up_details
      fill_in :password, with: 'plopplopplop'
      click_button 'Sign Up'
      expect(page.current_path).to eq('/users')
      expect(page).to have_content('is too long (maximum is 10 characters)')
    end

    scenario 'User cannot leave first_name field empty' do
      fill_in_sign_up_details
      fill_in :first_name, with: ''
      click_button 'Sign Up'
      expect(page.current_path).to eq('/users')
      expect(page).to have_content("Meow, what is your a first name?")
    end

    scenario 'User cannot leave last_name field empty' do
      fill_in_sign_up_details
      fill_in :last_name, with: ''
      click_button 'Sign Up'
      expect(page.current_path).to eq('/users')
      expect(page).to have_content("Meow, what is your last name?")
    end

    scenario 'User cannot leave email field empty' do
      fill_in_sign_up_details
      fill_in :email, with: ''
      click_button 'Sign Up'
      expect(page.current_path).to eq('/users')
      expect(page).to have_content("Meow, what is your email?")
    end

    scenario 'User cannot leave birthday field empty' do
      fill_in_sign_up_details
      fill_in :birthday, with: ''
      click_button 'Sign Up'
      expect(page.current_path).to eq('/users')
      expect(page).to have_content("Meow, when is your birthday?")
    end

    scenario 'User cannot leave password field empty' do
      fill_in_sign_up_details
      fill_in :password, with: ''
      click_button 'Sign Up'
      expect(page.current_path).to eq('/users')
      expect(page).to have_content("can't be blank")
    end

    scenario 'User cannot leave gender field empty' do
      fill_in_sign_up_details
      fill_in :gender, with: ''
      click_button 'Sign Up'
      expect(page.current_path).to eq('/users')
      expect(page).to have_content("Meow, what is your gender?")
    end
  end
end
