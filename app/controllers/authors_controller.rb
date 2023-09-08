class AuthorsController < ApplicationController
  before_action :load_author, except: [:index, :create]
  # GET /authors
  # Retrieve all authors
  def index
    authors = Author.all
    render json: authors
  end

  # GET /authors/:id
  # Retrieve a specific author by ID
  def show
    render json: @author
  end

  # POST /authors
  # Create a new author
  def create
    author = Author.new(author_params)

    if author.save
      render json: author, status: :created
    else
      render json: author.errors, status: :unprocessable_entity
    end
  end

  # PUT /authors/:id
  # Update an existing author by ID
  def update
    if @author.update(author_params)
      render json: @author
    else
      render json: @author.errors, status: :unprocessable_entity
    end
  end

  # DELETE /authors/:id
  # Delete an author by ID
  def destroy
    @author.destroy
    render json: { message: 'Author deleted successfully' }, status: :ok
  end

  private

  # Strong parameters for author creation and update
  def author_params
    params.require(:author).permit(:name, :speciality, :email, :phone)
  end

  def load_author
    @author = Author.find_by(id: params[:id])
    render json: { error: 'Author not found' }, status: :not_found unless @author.present?
  end
end
