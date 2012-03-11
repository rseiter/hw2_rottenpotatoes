class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # Make sure @all_ratings is set here so the index view can use it
    @all_ratings = Movie.all_ratings

    # Remember sort order and filter values
    # Should ratings be an argument instead?
debugger
    if params[:ratings] then
      @ratings = params[:ratings].keys
    else
      # Change for remembering code?
      @ratings = nil
    end
    @order = params[:order]

    # Support remembering sort and filtering
    # If no sort/filtering specified reapply remembered values and redirect_to so they appear in the URI
    # Modify lookup to include filtering using find_by_rating (or find_all_by?, how do we handle ratings hash?, maybe combine multiple finds or do custom SQL query?)
    if params[:order] then
      if @ratings then
        @movies = Movie.find(:all,
            :conditions => ['rating IN (?)', @ratings],
            :order => params[:order])
      else
        @movies = Movie.all(:order => params[:order])
      end
    else
      if @ratings then
        @movies = Movie.find(:all,
            :conditions => ['rating IN (?)', @ratings])
      else
        @movies = Movie.all
      end
    end
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
