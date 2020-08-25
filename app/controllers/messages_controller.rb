class MessagesController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @message = Message.new(message_params)
    authorize @message
    @message.project = @project
    @message.user = current_user
    if @message.save
      # redirect_to project_path(@project, anchor: "message-#{@message.id}")
      head :no_content
    else
      render "project/show"
    end
    ChatroomChannel.broadcast_to(
      @project,
      render_to_string(partial: "message", locals: { message: @message })
    )
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
