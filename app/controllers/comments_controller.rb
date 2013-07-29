class CommentsController < ApplicationController
  before_filter :get_room, :only=>[:index, :create]
  before_filter :get_comment, :only=>[:destroy, :update, :show]

  def index
    @comments = @room.comments
    authorize! :read, @room
  end

  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    @comment.room = @room
    authorize! :create, @comment
    @comment.save
  end

  def update
    authorize! :update, @comment
    @comment.update_attributes(params[:comment])
  end

  def destroy
    authorize! :destroy, @comment
    @comment.destroy
  end
  
  def show
    authorize! :read, @comment
  end

  private

  def get_room
    @room = Room.find(params[:room_id])
  end

  def get_comment
    @comment = Comment.find(params[:id])
  end

end
