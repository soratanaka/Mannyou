FactoryBot.define do
  factory :user do
    name { 'ユーザー１' }
    email { Faker::Internet.free_email }
    password { 'testtest' }
    password_confirmation {'testtest' }
    admin {'ture'}
  end
  factory :second_user, class: User do
    name { 'ユーザー２' }
    email { Faker::Internet.free_email }
    password { 'tanaka' }
    password_confirmation {'tanaka'}
    admin {'false'}
  end
end