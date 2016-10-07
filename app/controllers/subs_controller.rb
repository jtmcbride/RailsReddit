class SubsController < ApplicationController
  before_action :check_mod, only: [:edit, :update]
  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      render :new
    end
  end

  def index
    @subs = Sub.all
  end

  def edit
  end

  def update
    @sub.update(sub_params)
    redirect_to sub_url(@sub)
  end

  def show
    @sub = Sub.find(params[:id])
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def check_mod
    @sub = Sub.find(params[:id])
    unless current_user.id == @sub.moderator_id
      redirect_to root_url
    end
  end
end
