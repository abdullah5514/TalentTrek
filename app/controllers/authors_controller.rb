class AuthorsController < ApplicationController
    def index
      authors = Author.all
      render json: authors
    end
  
    def show
      author = Author.find_by(id: params[:id])

      if author
        render json: author
      else
        render json: { error: 'Author not found' }, status: :not_found
      end
    end
  
    def create
      author = Author.new(author_params)
  
      if author.save
        render json: author, status: :created
      else
        render json: author.errors, status: :unprocessable_entity
      end
    end
  
    def update
      author = Author.find(params[:id])
  
      if author.update(author_params)
        render json: author
      else
        render json: author.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      author = Author.find_by(id: params[:id])
      author ? (author.destroy; render(json: { message: 'Author deleted successfully' }, status: :ok)) : (render(json: { error: 'Author not found' }, status: :not_found))
    end
  
    private
  
    def author_params
      params.require(:author).permit(:name, :speciality, :email, :phone)
    end
  end
  