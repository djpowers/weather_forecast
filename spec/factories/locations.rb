FactoryBot.define do
  factory :location do
    inputted_address { '1 Infinite Loop Cupertino, CA 95014' }
    latitude { 37.331405 }
    longitude { -122.0304185 }
    postal_code { '95014' }
    normalized_address do
      'Apple Infinite Loop, 1, Infinite Loop, Apple Campus, Cupertino, Santa Clara County, California, 95014, United States'
    end
  end
end
