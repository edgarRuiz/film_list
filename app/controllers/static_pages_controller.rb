class StaticPagesController < ApplicationController
  def index
    if user_signed_in?
      redirect_to movies_my_movies_path
    end
  end
end
