class MessagesController < ApplicationController
  load_and_authorize_resource
  before_action :find_message, only: [:show, :edit, :update, :destroy]

  def index
    @messages = if params[:search] and not params[:search].empty?
      Message.search(params[:search])
    else
      Message.all.order("created_at DESC")
    end
  end

  def show
  end

  def new
    @message = current_user.messages.build
  end

  def create
    @message = current_user.messages.build(message_params)
    if @message.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @message.update(message_params)
      redirect_to message_path
    else
      render 'edit'
    end
  end

  def destroy
    @message.destroy
    redirect_to root_path
  end

  private
  def message_params
    params.require(:message).permit(:title, :description)
  end

  def find_message
    @message = Message.find(params[:id])
  end
end
