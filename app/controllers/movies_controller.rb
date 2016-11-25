class MoviesController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @movie = Movie.new
  end
  
  def index
  end
  
  def search
    movie_name = params[:movie_name]
    response = HTTParty.get("http://www.omdbapi.com/?t=#{movie_name}&y=&plot=short&r=json")
    
    if response["Response"] == "True"
      @title = response["Title"]
      @release_date = response["Released"]
      @director = response["Director"]
      @poster = response["Poster"]
      @runtime = response["Runtime"]
      @genre = response["Genre"]
      @rated = response["Rated"]
      @plot = response["Plot"]
      
      
    else
      flash[:danger] = 'Movie was not found.  Please try again.  Perhaps title was misspelled.'
      redirect_to movies_index_path
    end
  end
  
  def create
    @movie = Movie.new(:title => params[:title], :director => params[:director],
                                        :release_date => params[:release_date],:poster => params[:poster], 
                                        :runtime => params[:runtime], :genre => params[:genre] , 
                                        :rated => params[:rated], :plot => params[:plot], :user => current_user)
    if @movie.save
      redirect_to movies_my_movies_path
    else
      render html: "failed"
    end
  end
  
  def my_movies
    @movies = Movie.where(:user => current_user)
  end
  
end