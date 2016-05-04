App.conversation = App.cable.subscriptions.create "ConversationChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    
  disconnected: ->
    # Called when the subscription has been terminated by the server
    
  received: (data) ->
    alert("You received");

  speak: (user_id, text, conversation_id)->
    @perform 'speak', {user_id: user_id, text: text, conversation_id: conversation_id }
