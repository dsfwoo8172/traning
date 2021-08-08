FactoryBot.define do
  factory :user do
    email {'abc@gmail.com'}
    password {'111111'}
    password_confirmation { password }
    role {'admin'}
  end

  factory :random_user, class: User do
    email {"#{Faker::Internet.user_name}@gamil.com"}
    password {'111111'}
    password_confirmation { password }
    role {'general_user'}
    username {'jerry'}
  end
end