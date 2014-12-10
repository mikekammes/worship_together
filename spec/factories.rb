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
  start_time '9:00 AM'
  finish_time '10:30 AM'
  day_of_week 'sunday'
  location 'sanctuary'
	transient { num_rides 1 }

	after(:create) do |service, evaluator|
	    create_list(:ride, evaluator.num_rides, service: service)
	end
    end

    factory :ride do
      user
      meeting_location 'euler parking lot'
      leave_time '8:30 AM'
      return_time '11:00 AM'
      vehicle 'maserati'
      seats_available 5
      number_of_seats 6
      date '1/1/2015'
      #date Date.new(2015,1,1)
      service
    end

    factory :user_ride do
      user
      ride
    end
end
