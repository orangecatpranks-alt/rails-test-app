class Api::V1::MoviesController < Api::BaseController
  def index
    @movies = Movie.page(params[:page]).per(params[:per_page])

    render json: {
      data: @movies,
      meta: {
        current_page: @movies.current_page,
        total_pages: @movies.total_pages,
        total_count: @movies.total_count,
        per_page: @movies.limit_value
      }
    }
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      render json: { data: @movie }, status: :created
    else
      render json: {
        errors: @movie.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :description, :release_year)
  end
end
