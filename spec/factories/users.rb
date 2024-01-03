FactoryBot.define do
  factory :user do
    nickname              {'test'}
    email                 {'test@example'}
    password              {'a00000'}
    password_confirmation {password}
    first_name            {'田中'}
    second_name           {'太郎'}
    f_name_kana           {'タナカ'}
    s_name_kana           {'タロウ'}
    birthday              {'2000/01/01'}
  end
end