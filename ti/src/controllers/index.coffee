io = require 'socket.io'

uri = 'http://192.168.1.2:5455'
socket = io.connect uri

defaultTextAlloy = 'I am a Alloy textarea'
defaultTextTI = 'I am a TI textarea'

socket.on 'greeting', (data) ->
  greeting = "Hello #{data.hello}!!!!!"
  setTimeout ->
    $.label.text = greeting
  , 5000

doClick = (e) ->
  alert $.label.text

textArea = Ti.UI.createTextArea
  borderWidth: 2,
  borderColor: '#bbb'
  borderRadius: 5
  color: '#888'
  font: {fontSize:20, fontWeight:'bold'}
  keyboardType: Ti.UI.KEYBOARD_NUMBER_PAD
  returnKeyType: Ti.UI.RETURNKEY_GO
  textAlign: 'left'
  value: defaultTextTI
  top: 60
  width: 300, height : 300

send = ->
  if $.textArea.text isnt defaultTextAlloy and $.textArea.text isnt ''
    socket.emit 'send', {user: 'user', message: $.textArea.value}
    $.textArea.value = ''

socket.on 'message', (data) ->
  if textArea.value is defaultTextTI
    textArea.value = "#{data.user}: #{data.message}"
  else
    textArea.value += "\n#{data.user}: #{data.message}"

$.index.add textArea
$.index.open()
