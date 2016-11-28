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
    
    #If a movie with same title and director exists then it is already in the list
    title = params[:title]
    director = params[:director]
    movie = Movie.where(:title => title, :director => director)
    if movie.empty?
      @movie = Movie.new(:title => title, :director => director,
                                          :release_date => params[:release_date],:poster => params[:poster], 
                                          :runtime => params[:runtime], :genre => params[:genre] , 
                                          :rated => params[:rated], :plot => params[:plot], :user => current_user)
      if @movie.save
        flash[:success] = "#{title} was successfully added to your list!"
        redirect_to movies_my_movies_path
      else
        flash[:danger] = "Could not add #{title} to your list.  Please try again"
        redirect_to movies_my_movies_path
      end
    else 
      flash[:danger] = "You already have #{title} in your list!"
      redirect_to movies_my_movies_path
    end
    
  end
  
  def my_movies
    @movies = Movie.where(:user => current_user).paginate(:page => params[:page], :per_page => 5)
  end
  
  def destroy
    movie = Movie.find(params[:id])
    
    if movie.destroy
      flash[:success] = "#{movie.title} was successfully removed from your list"
      redirect_to movies_my_movies_path
    else
      flash[:danger] = "#{movie.title} could not be deleted"
      redirect_to movies_my_movies_path
    end
    
  end
  
end