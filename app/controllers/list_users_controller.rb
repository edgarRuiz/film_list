class ListUsersController < ApplicationController
  
  def new
    @list_user = ListUser.new
  end
  
  def index
    @list_user = ListUser.all
  end

  def show
  end
  
  def create
    @list_user = ListUser.new(list_user_params)
    @list_user.user = current_user
    if @list_user.save
      redirect_to list_users_index_path
    else
      redirect_to new_list_user_path
    end
  end
  
  private
  
    def list_user_params
      params.require(:list_user).permit(:list_name)
    end
  
end
