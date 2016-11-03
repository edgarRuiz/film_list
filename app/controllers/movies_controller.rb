class MoviesController < ApplicationController
  
  def new
    @movie = Movie.new
  end
  
  def index
  end
  
  def search
    movie_name = params[:movie_name]
    response = HTTParty.get("http://www.omdbapi.com/?t=#{movie_name}&y=&plot=short&r=json")
    
    if response["Response"] == "True"
      @movie_title = response["Title"]
      @movie_release_date = response["Released"]
      @movie_director = response["Director"]
      @movie_poster = response["Poster"]
      @movie_runtime = response["Runtime"]
      @movie_genre = response["Genre"]
      @movie_rated = response["Rated"]
      @movie_plot = response["Plot"]
      
    else
      redirect_to movies_path
    end
  end
  
end