FactoryGirl.define do 
    factory :event do
        association(:user)
        name "Event"
        start_at Time.current
        end_at Time.current
        color "blue"
    end
end