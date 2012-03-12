class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.get_all_ratings
    if params[:sort] == nil
      params[:sort] = session[:sort]
    end
    if params[:commit] == "Refresh"
      @ratings = params[:ratings] ? params[:ratings].keys : []
    else
      if params[:ratings] != session[:ratings]
        params[:ratings] = session[:ratings]
        redirect_to movies_path params
      end
      @ratings = params[:ratings] ? params[:ratings] : @all_ratings
    end
    @sort = Movie.get_sortables.include?(params[:sort]) ? params[:sort] : nil
    session[:ratings] = @ratings
    session[:sort] = @sort
    @movies = Movie.
      where(:rating => @ratings ).
      order @sort
      #find(:all, 
      #:order => Movie.get_sortables.include?(params[:sort]) ? params[:sort] : nil)
      
    # if params[:sort] == 'title'
      # @movies = @movies.sort_by{|m| m.title}
    # end
#     
    # if params[:sort] == 'release date'
      # @movies = @movies.sort_by{|m| m.release_date}
    # end
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
