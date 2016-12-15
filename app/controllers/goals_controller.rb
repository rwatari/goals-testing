class GoalsController < ApplicationController
  def index
    @goals = Goal.where(user_id: params[:user_id])
  end

  def show
    @goal = Goal.includes(:user).find_by(id: params[:id])
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)

    @goal.user_id = current_user.id
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = current_user.goals.find_by(id: params[:id])
  end

  def update
    @goal = current_user.goals.find_by(id: params[:id])
    if @goal.update_attributes(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find_by(id: params[:id])
  end

  private

  def goal_params
    params.require(:goal).permit(:content, :completed, :private)
  end
end
