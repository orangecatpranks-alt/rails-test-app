class Api::V1::MoviesController < ApplicationController
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
end
