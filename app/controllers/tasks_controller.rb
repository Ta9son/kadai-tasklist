class TasksController < ApplicationController
    before_action :set_task,only:[:show,:edit,:update,:destroy]
    before_action :correct_user, only: [:destroy]
    
    def index
        if logged_in?
            @tasks = Task.all.page(params[:page]).per(15)
            @task = current_user.tasks.build
        else
            redirect_to :login
        end
    end
    
    def show
        
        
        
    end

    def new
        @task = Task.new
    end

    def create
        
        @task = current_user.tasks.build(task_params)
        if @task.save
            flash[:success] = 'メッセージを投稿しました。'
            redirect_to root_url
        else
            flash.now[:danger] = 'メッセージの投稿に失敗しました。'
            render :new
        end
    end

    def edit
        
    end

    def update
        
        
        if @task.update(task_params)
            flash[:success] = "タスクは正常に更新されました"
            redirect_to @task
        else
            flash.now[:danger] = "タスクは更新されませんでした"
            render :edit
        end
    end

    def destroy
        @task.destroy
        flash[:success] = 'メッセージを削除しました。'
        redirect_to root_url
        
        
    end
    
    
    
    private
    
    
    def set_task
        @task = Task.find(params[:id])
    end
    
    
    
    
    def task_params
        params.require(:task).permit(:content,:status)
        
    end
    
    def correct_user
        @task = current_user.tasks.find_by(id: params[:id])
        unless @task
            redirect_to root_url
        end
    end
end
