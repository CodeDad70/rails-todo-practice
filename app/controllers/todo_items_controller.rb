class TodoItemsController < ApplicationController

  before_action :set_todo_list
  before_action :set_todo_item, except: [:create]

  def create 
    @todo_item = @todo_list.todo_items.create(todo_items_params)
    redirect_to @todo_list
  end

  def destroy
      if @todo_item.destroy
          flash[:success] = "Item Deleted"
      else flash[:error] = "Can't Delete Item"
      end
      redirect_to @todo_list
  end

  def complete
    @todo_item.update_attribute(:completed_at, Time.now)
    redirect_to @todo_list
  end


  private

  def set_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def set_todo_item
    @todo_item = @todo_list.todo_items.find(params[:id]) 
  end

  def todo_items_params
    params.require(:todo_item).permit(:content)
  end

end
