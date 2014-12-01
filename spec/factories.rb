FactoryGirl.define do
    factory :user do
	sequence(:name) { |i| "User #{i}" }
	sequence(:email) { |i| "user.#{i}@example.com" }
	password 'password'
	password_confirmation 'password'

	factory :admin do
	    admin true
	end
    end

    factory :church do
      sequence(:name) {|i| "church #{i}" }
      user
    end


    factory :service do
	church
	transient { num_rides 1 }

	after(:create) do |service, evaluator|
	    create_list(:ride, evaluator.num_rides, service: service)
	end
    end

    factory :ride do
      user
      service
    end

    factory :user_ride do
      user
      ride
    end
end
