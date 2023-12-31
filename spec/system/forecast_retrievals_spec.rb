require 'rails_helper'

RSpec.describe 'ForecastRetrievals', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'shows the address input and submit button' do
    visit root_path
    expect(page).to have_content('Address')
    expect(page).to have_button('Get forecast')
    within('form') do
      fill_in 'Address', with: '1 Infinite Loop Cupertino, CA 95014'
    end
    VCR.use_cassette('forecast_retrieval') do
      click_button 'Get forecast'
    end
    expect(page).to have_content('Forecast for 95014')
    expect(page).to have_content('Current temperature is 76° F')
    expect(page).to have_content('Cloudy')
    expect(page).to have_content('Forecast valid from October 14, 2023 21:00 UTC to October 14, 2023 22:00 UTC.')
  end

  it 'caches requests and indicates when a forecast is cached' do
    visit root_path
    within('form') do
      fill_in 'Address', with: '1 Infinite Loop Cupertino, CA 95014'
    end
    VCR.use_cassette('forecast_retrieval') do
      click_button 'Get forecast'
    end

    click_link 'Look up new address'
    within('form') do
      fill_in 'Address', with: '1 Infinite Loop Cupertino, CA 95014'
    end
    VCR.use_cassette('forecast_retrieval') do
      click_button 'Get forecast'
    end
    expect(page).to have_content('Forecast data retrieved from cache')
  end

  it 'handles errors' do
    visit root_path
    within('form') do
      fill_in 'Address', with: 'zzzzzzzzzz'
    end
    VCR.use_cassette('forecast_retrieval') do
      click_button 'Get forecast'
    end
    expect(page).to have_content('There was an error. Please try again.')
  end
end
