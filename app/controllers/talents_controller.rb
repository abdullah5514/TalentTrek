class TalentsController < ApplicationController
    def index
      talents = Talent.all
      render json: talents
    end
  
    def show
      talent = Talent.find(params[:id])
      render json: talent
    end
  
    def create
      talent = Talent.new(talent_params)
  
      if talent.save
        render json: talent, status: :created
      else
        render json: talent.errors, status: :unprocessable_entity
      end
    end
  
    def update
      talent = Talent.find(params[:id])
  
      if talent.update(talent_params)
        render json: talent
      else
        render json: talent.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      talent = Talent.find_by(id: params[:id])
      
      talent ? (talent.destroy; render(json: { message: 'Talent deleted successfully' }, status: :ok)) : (render(json: { error: 'Talent not found' }, status: :not_found))
    end
    
  
    private
  
    def talent_params
      params.require(:talent).permit(:name, :roll_no, :email)
    end
  end
  