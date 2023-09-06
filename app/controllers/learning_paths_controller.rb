class LearningPathsController < ApplicationController
    def index
      learning_paths = LearningPath.all
      render json: learning_paths
    end
  
    def show
      learning_path = LearningPath.find(params[:id])
      render json: learning_path
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
      learning_path = LearningPath.find(params[:id])
      learning_path.destroy
      head :no_content
    end
  
    private
  
    def learning_path_params
      params.require(:learning_path).permit(:name)
    end
  end
  