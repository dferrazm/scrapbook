FactoryGirl.define do
  factory :user do
    username 'jdoe'
    password 'change123'
    role Role::NORMAL

    factory :admin_user do
      role Role::ADMIN
    end

    factory :guest_user do
      role Role::GUEST
    end
  end
end
