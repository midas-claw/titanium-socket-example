express = require 'express'
io = require 'socket.io'

app = express()
server = require('http').createServer app
io = io.listen server

server.listen 5455

io.sockets.on 'connection', (socket) ->
  socket.emit 'greeting', { hello: 'world' }
  socket.on 'send', (data) ->
    socket.emit 'message', data
