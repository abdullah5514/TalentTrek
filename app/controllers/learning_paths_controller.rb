class LearningPathsController < ApplicationController
  
    def index
      learning_paths = LearningPath.all
      render json: learning_paths
    end
  
    def show
      learning_path = LearningPath.find_by(id: params[:id])
      if learning_path
        render json: learning_path
      else
        render json: { error: 'Learning path not found' }, status: :not_found
      end
    end
  
    def create
      learning_path = LearningPath.new(learning_path_params)
  
      if learning_path.save
        render json: learning_path, status: :created
      else
        render json: learning_path.errors, status: :unprocessable_entity
      end
    end
  
    def update
      learning_path = LearningPath.find(params[:id])
  
      if learning_path.update(learning_path_params)
        render json: learning_path
      else
        render json: learning_path.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      learning_path = LearningPath.find_by(id: params[:id])

      learning_path ? (learning_path.destroy; render(json: { message: 'Learning path deleted successfully' }, status: :ok)) : (render(json: { error: 'Learning path not found' }, status: :not_found))
    end
  
    private
  
    def learning_path_params
      params.require(:learning_path).permit(:title,:start_date, :end_date)
    end
  end
  