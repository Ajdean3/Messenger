App.conversation = App.cable.subscriptions.create "ConversationChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    alert("connected");
  disconnected: ->
    # Called when the subscription has been terminated by the server
    alert("disconnected");
  received: (data) ->
    # Called when there's incoming data on the websocket for this channel

  speak: (user_id, text)->
    @perform 'speak', {user_id: user_id, text: text, conversation_id: conversation_id }
