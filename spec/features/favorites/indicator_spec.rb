require 'rails_helper'


RSpec.describe 'favorites indicator in navigation bar' do
  it 'shows a count of favorited pets'do

    visit "/shelters"

    expect(page).to have_content('(0) Favorited Pets')
  end
end
