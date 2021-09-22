class UsersController < ApplicationController

  def index
    @users=User.all
    @book=Book.new
    @user=current_user
  end

  def show
    @user=User.find(params[:id])
    @books=@user.books
    @book=Book.new
    @today_book=@books.created_today
    @yesterday_book=@books.created_yesterday
    @week_book=@books.created_week
    @lastweek_book=@books.created_lastweek
  end

  def edit
    @user=User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end

end
