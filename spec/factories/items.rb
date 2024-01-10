FactoryBot.define do
  factory :item do
    item              {'オムライス'}
    explanation       {'作りたて'}
    category_id       {'2'}
    condition_id      {'3'}
    delivery_cost_id  {'2'}
    prefectures_id    {'2'}
    shipment_day_id   {'2'}
    price             {'3000'}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
