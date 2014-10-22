class User < ActiveRecord::Base
    validates :name, presence: true, uniqueness:true, length: {maximum:50}
    validates :email, presence: true, uniqueness:true
    validates :password, presence: true
end
