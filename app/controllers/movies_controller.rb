class MoviesController < ApplicationController

  # let helper know these private methods
  helper_method :sort_column
  
  
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    
    @all_ratings = ['G','PG','PG-13','R']
    
    session[:movies] = Movie.all
  
    if params[:ratings]
      session[:movies]  = session[:movies].where(rating: params[:ratings].keys)
      session[:ratings] = params[:ratings]
    elsif session[:ratings]
      params[:ratings] = session[:ratings]
      session[:movies]  = session[:movies].where(rating: params[:ratings].keys)
    end
    
    if params[:sort]
      session[:movies] = session[:movies].order(sort_column)
      session[:sort] = params[:sort]
    elsif session[:sort]
      params[:sort] = session[:sort]
      session[:movies] = session[:movies].order(sort_column)
    end
    
    @movies = session[:movies]
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path # directs to thw show view
  end

  private
  
  # sort by title
  def sort_column
    Movie.column_names.include?(params[:sort]) ? params[:sort] : nil
  end
end
