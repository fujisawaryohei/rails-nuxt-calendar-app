class Api::V1::TodosController < ApplicationController
  def index
    todos = Todo.all
    render json: todos
  end
      
  def show
    todo = Todo.find(params[:id])
    if todo
      render json: todo
    else
      render json: { error_message: '存在しません'}
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
