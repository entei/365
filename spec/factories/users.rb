FactoryGirl.define do
    factory :user do
        username "Sam Rockwell"
        sequence(:nickname) {|i| "nickname#{i}" }
        sequence(:email) {|i| "email#{i}@exemple.com" }
        password "12345678"
        password_confirmation "12345678"
    end
end