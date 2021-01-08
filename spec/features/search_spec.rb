require 'rails_helper'

# As a user
# When I visit "/"
# And I fill in "Emily" in the textfield(Note: Use the existing search form)
# And I click "Get Poems"
# Then I should be on page "/search"
# Then I should see a list of the first 10 poems
# Then I should see the tone or tones listed for each poem.
# For each poem I should see
# - Title
# - Author
# - The poem(as a single string)
# I should also see:
# - The tone or tones for each poem

describe "User can visit search path" do
  it "is redirected to search page" do
    visit '/'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Welcome to Poetry and Emotion')
    expect(page).to have_selector('input')

    fill_in(:author, :with => "Emily")
    click_button("Get Poems")

    expect(current_path).to eq("/search")

    expect(page).to have_content("10 Poems")

    within(first('.poems')) do
      expect(page).to have_css('.title')
      expect(page).to have_css('.author')
      expect(page).to have_css('.lines')
      expect(page).to have_css('.tones')
    end
  end
end
