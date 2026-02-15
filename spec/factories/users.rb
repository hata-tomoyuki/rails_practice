FactoryBot.define do
  factory :user do
    nickname { 'test' }
    sequence :email do |n|
      "test#{n}@aaa.test"
    end
    password { 'testtest' }
    password_confirmation { 'testtest' }
  end
end
