RSpec.feature 'Post display', type: :feature do
  scenario 'User sumbits a post' do
    sign_up
    click_link 'New post'
    fill_in 'Message', with: 'Hello, world!'
    click_button 'Submit'
    expect(page).to have_content('Hello, world!')
  end

  scenario 'User submits multiline post' do
    sign_up
    click_link 'New post'
    fill_in 'Message', with: "Hello, world! \nGoodbye, world!"
    click_button 'Submit'
    expect(page.text).to have_content("Hello, world! \nGoodbye, world!")
  end

  scenario 'User views newest posts first' do
    sign_up
    click_link 'New post'
    fill_in 'Message', with: 'First message'
    click_button 'Submit'
    click_link 'New post'
    fill_in 'Message', with: 'Second message'
    click_button 'Submit'
    expect('Second message').to appear_before('First message')
  end

  scenario 'User can see the time a post was submitted' do
    post = Post.create('message' => 'Time')
    sign_up
    expect(page).to have_content(post.created_at)
  end
end