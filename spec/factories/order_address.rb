FactoryBot.define do
  factory :order_address do
    post_code       {"123-4567"}
    prefectures_id  {2}
    city            {"テスト市テスト町"}
    street_address  {"1-1"}
    building        {"テストマンション"}
    phone_number    {"09012345678"}
    token           { Faker::Internet.uuid }
  end
end