class TasksController < ApplicationController
  def index
    @incomplete_tasks = Task.where(complete: false)
    @complete_tasks = Task.where(complete: true)
  end

  def auto_complete_search
    @tasks_result = Task.searchable(params[:search_term])
    render :json => @tasks_result.to_json
  end

  def new
    @task = Task.new
    respond_to do |f|
      f.html { redirect_to new_task_url }
      f.js
    end
  end

  def create
    @task = Task.create!(allowed_params)

    respond_to do |f|
      f.html { redirect_to tasks_url }
      f.js
    end
  end

  def update
    @task = Task.find(params[:id])
    @task.update_attributes!(allowed_params)

    respond_to do |f|
      f.html { redirect_to tasks_url }
      f.js
    end
  end

  def destroy
    @task = Task.destroy(params[:id])

    respond_to do |f|
      f.html { redirect_to tasks_url }
      f.js
    end
  end

  private

  def allowed_params
    params.require(:task).permit(:subject, :name)
  end
end