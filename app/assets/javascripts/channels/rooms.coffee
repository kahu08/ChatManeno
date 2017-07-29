#check if there is a id for messages and subscribe while providing rooms id
jquery(document).on 'turbolinks:load', ->
  messages = $('#messages')
  if $('messages').length > 0

    #make page automatically scroll to the new messages
    messages_to_bottom = -> messages.scrollTop(messages.prop("scrollHeight"))
    messages_to_bottom()

App.global_chat = App.cable.subscriptions.create {
  channel: "ChatRoomsChannel"
  chat_room_id: messsages.data('chat-room-id')
},
#listen for the submit event
$('#new_message').submit (e) ->
  $this = $(this)
  textarea = $this.find('#message_body')
  #check if message is greater than 1 word
  if $.trim(textarea.val()).length > 1
    #broadcast to everyone in the room
    App.global_chat.send_message textarea.val(), messages.data('chat_room_id')
    #clear the field and prevent submission
    textarea.val('')
  e.preventDefault()
  return false
#when subscripton is ready for use by server
connected: ->

#when connection is to be terminated by server
disconnected: ->

#when the data is received by the server
received: (data) ->
  messages.append data['message']
  messages_to_bottom

send_message: (message, chat_room_id) ->
  @perform 'send_message', message: chat_room_id: chat_room_id
