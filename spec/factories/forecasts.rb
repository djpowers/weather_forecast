FactoryBot.define do
  factory :forecast do
    temperature { 72 }
    short { 'Tonight' }
    icon { 'https://api.weather.gov/icons/' }
    number { 1 }
    temperature_unit { 'F' }
    start_time { 1.hour.ago }
    end_time { 1.hour.from_now }
    location
  end
end
