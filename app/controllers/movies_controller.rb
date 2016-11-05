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
      @title = response["Title"]
      @release_date = response["Released"]
      @director = response["Director"]
      @poster = response["Poster"]
      @runtime = response["Runtime"]
      @genre = response["Genre"]
      @rated = response["Rated"]
      @plot = response["Plot"]
      
      
    else
      redirect_to root_path
    end
  end
  
  def create
    @movie = Movie.new(:title => params[:title], :release_date => params[:release_date],
                      :director => params[:director],:poster => params[:poster], 
                      :runtime => params[:runtime], :genre => params[:genre] , 
                      :rated => params[:rated], :plot => params[:plot], :user => current_user)
    if @movie.save
      redirect_to movies_my_movies_path
    else
      render html: "failed"
    end
  end
  
  def my_movies
    @movies = Movie.all()
  end
  
end