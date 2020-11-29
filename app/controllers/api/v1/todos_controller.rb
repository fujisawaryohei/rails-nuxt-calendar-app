class Api::V1::TodosController < ApplicationController
  def index
    todos = Todo.all.order(created_at: :desc)
    render json: todos, each_serializer: TodoSerializer
  end
      
  def show
    todo = Todo.find_by(id: params[:id])
    unless todo.nil?
      render json: todo
    else
      render json: { error_message: 'Not Found'}
    end
  end
      
  def create
    todo = Todo.new(set_params)
    if todo.save
      render json: { success_message: '保存しました' }
    else
      render json: todo.errors.messages
    end
  end
      
  def update
    todo = Todo.find(params[:id])
    if todo.update(set_params)
      render json: { success_message: '更新しました' }
    else
      render json: todo.errors.messages
    end
  end
      
  def destroy
    todo = Todo.find(params[:id])
    todo.destroy
    render json: { success_message: '削除しました' } 
  end
    
  private
  def set_params
    params.require(:todo).permit(:title, :content, :is_done, :date, :time)
  end
end
