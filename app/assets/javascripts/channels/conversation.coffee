App.cable = ActionCable.createConsumer("/cable")
App.conversation = App.cable.subscriptions.create {channel: "ConversationChannel", conversation_id: 2},
  connected: ->
    # Called when the subscription is ready for use on the server
    #alert("connected");
  disconnected: ->
    # Called when the subscription has been terminated by the server
    
  received: (data) ->
    alert("received");
    $('#message-holder').append("<br><div class = 'message'>#{data['user_email']}: #{data['text']}</div>");
  speak: (user_email, user_id, text, conversation_id) ->
    alert("send");
    @perform 'speak', {user_email: user_email, user_id: user_id , text: text, conversation_id: conversation_id }

