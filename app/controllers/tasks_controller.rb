class TasksController < ApplicationController
  before_action :set_task, only: [:update, :destroy]

  def index
    @tasks = Task.all
    json_response(@tasks)
  end

  def create
    @task = Task.new(task_param)
    if @task.save
      json_response(@task, :created)
    else
      json_response(@task.errors, :unprocessable_entity)
    end
  end

  def update
    if @task.update(task_param)
      json_response(@task, :ok)
    else
      json_response(@task, :no_content)
    end
  end

  def destroy
    @task.destroy
    head :no_content
  end

  private

  def task_param
    params.require(:task).permit(:title)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
