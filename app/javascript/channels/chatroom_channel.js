import consumer from './consumer';

const initChatroomCable = () => {
  // If the user is in a chatroom show page, subscribe them
  // Check if there is a messages container with a certain data attribute
  const messagesContainer = document.getElementById('messages');
  // If there is, subscribe the user
  if (messagesContainer) {
    const id = messagesContainer.dataset.chatroomId;
    console.log("Hey 🙌 I'm connected to a chatroom");
    consumer.subscriptions.create({ channel: "ChatroomChannel", id: id }, {
      received(data) {
        messagesContainer.insertAdjacentHTML('beforeend', data) // called when data is broadcast in the cable
      },
    });
  }
}

export { initChatroomCable }
