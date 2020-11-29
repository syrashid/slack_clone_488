class MessagesController < ApplicationController
  def create
    # Find the chatroom for the message
    @chatroom = Chatroom.find(params[:chatroom_id])
    # Create the message instance
    @message = Message.new(message_params)
    # Associate message with chatroom
    @message.chatroom = @chatroom
    @message.user = current_user
    # Save the message
    if @message.save
      ChatroomChannel.broadcast_to(
        @chatroom,
        render_to_string(partial: "message", locals: { message: @message })
      )
      redirect_to chatroom_path(@chatroom, anchor: "message-#{@message.id}")
    else
      render 'chatroom/show'
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
