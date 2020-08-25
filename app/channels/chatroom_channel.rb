class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    project = Project.find(params[:id])
    stream_for project
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
