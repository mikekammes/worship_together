class UsersController < ApplicationController
    before_action :ensure_user_logged_in, only: [:edit, :update, :destroy]
    before_action :ensure_correct_user, only: [:edit, :update]
    before_action :ensure_user_not_logged_in, only: [:create, :new]
    before_action :ensure_admin, only: [:destroy]

    def index
	@users = User.all
    end

    def new
	@user = User.new
    end

    def create
	@user = User.new(user_params)
	if @user.save
	    flash[:success] = "Welcome to the site, #{@user.name}"
	    redirect_to @user
	else
	    flash.now[:danger] = "Unable to create new user"
	    render 'new'
	end
    end

    def update
	@user=User.find(params[:id])
      if params[:attend_church]
        @user.church_id = params [:church_attend]
        if @user.save
          flash[:success] = "Attending church"
          redirect_to root_path
        else
          flash[:danger] = "Can't attend church"
          redirect_to root_path
        end
      else
        if @user.update(user_params)
          flash[:success] = "Updated, #{@user.name}"
          redirect_to user_path
        else
          flash.now[:danger] = "Unable to modify your account"
          render 'edit'
        end
      end
    end

    def edit
      @user = User.find(params[:id])
      rescue
      flash[:danger] = "Unable to find user"
      redirect_to users_path
    end

    def destroy
	@user=User.find(params[:id])
      if current_user?(@user) && @user.admin?
        flash[:danger] = "you are an admin and can't delete yourself!"
        redirect_to root_path
      else @user.destroy
       flash[:success] = "Destroyed the user"
       redirect_to users_path
    end
    end

    def show
	@user = User.find(params[:id])
    rescue
	flash[:danger] = "Unable to find user"
	redirect_to users_path
    end

    def edit
     @user = User.find(params[:id])
    rescue
	flash[:danger] = "Unable to find user"
	redirect_to users_path
    end

    private

    def user_params
	params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def ensure_user_logged_in
	unless current_user
	    flash[:warning] = 'Not logged in'
	    redirect_to login_path
	end
    end

  def ensure_user_not_logged_in
    if logged_in?
      flash[:warning] = 'Already Logged in'
      redirect_to root_path
    end 
  end
    def ensure_correct_user
	@user = User.find(params[:id])
	unless current_user?(@user)
	    flash[:danger] = "Cannot edit other user's profiles"
	    redirect_to root_path
	end
    rescue
	flash[:danger] = "Unable to find user"
	redirect_to users_path
    end

    def ensure_admin
	unless current_user.admin?
	    flash[:danger] = 'Only admins allowed to delete users'
	    redirect_to root_path
	  end
  end
end
