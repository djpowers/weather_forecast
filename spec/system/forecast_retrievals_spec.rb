require 'rails_helper'

RSpec.describe 'ForecastRetrievals', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'shows the address input and submit button' do
    visit root_path
    expect(page).to have_content('Address')
    expect(page).to have_button('Get Forecast')
  end
end
