class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :service
  has_many :user_rides
  has_many :users, through: :user_rides
  
  validates :meeting_location, presence: true
  validates :service, presence: true
  validates :user, presence: true
  validates :leave_time, presence: true
  validates :return_time, presence: true
  validates :vehicle, presence: true
  validates :seats_available, presence: true, :numericality => { only_integer: true }
  validates :number_of_seats, presence: true, :numericality => { only_integer: true, greater_than_or_equal_to: 0 }
  validates :date, presence: true
  
  validate :enough_seats
  def enough_seats
    if(seats_available && number_of_seats)
      errors.add(:seats_available, 'there are not enough seats avaiable') unless (seats_available <= number_of_seats)
      errors.add(:seats_available, 'there cannot be negative seats available') unless (seats_available >= 0)
    end
  end
  
  validate :valid_return_time
  def valid_return_time
    if (leave_time && return_time)
      errors.add(:return_time, 'you cannot return before you leave!') unless ( leave_time < return_time)
    end
  end
  
  validate :valid_date_creation
  def valid_date_creation
    if (:date)
      #errors.add(:date, 'you cannot create a ride for today') unless ( :date > Date.today)
      errors.add(:date, 'you cannot create a ride for today') unless (:date )
    end
  end
end
