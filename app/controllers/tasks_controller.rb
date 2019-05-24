class TasksController < ApplicationController
    before_action :require_user_logged_in
    before_action :correct_user, only: [:edit,:destroy]
    
    def index
        @tasks = current_user.tasks.order(id: :desc).page(params[:page]).per(10)
    end 
    
    def show
        @task = current_user.tasks.find_by(id: params[:id])
    end 
    
    def new
        @task = current_user.tasks.build
    end 
    
    def create
        @task = current_user.tasks.build(task_params)
        
        if @task.save
            flash[:success] = "Taskが正常に作成されました"
            redirect_to @task 
        else
            flash.now[:danger] = "Taskが作成されませんでした"
            render :new
        end 
    end 
    
    def edit 
        @task = current_user.tasks.find(params[:id])
    end 
    
    def update
        @task = current_user.tasks.find(params[:id])
        
        if @task.update(task_params)
            flash[:success] = "Taskが正常に更新されました"
            redirect_to @task 
        else 
            flash.now[:danger] = "Taskが更新されませんでした"
            render :edit
        end
    end 
    
    def destroy
        @task.destroy
        
        flash[:success] = "Taskが正常に消去されました"
        redirect_to root_url
    end 
    
    
    
    
    
    private
    
    

    
    def correct_user
        @task = current_user.tasks.find_by(id: params[:id])
        unless @task
            redirect_to root_url
        end 
    end 
            
    
    
    #Strong parameter
    def task_params
        params.require(:task).permit(:content,:status)
    end 
end



