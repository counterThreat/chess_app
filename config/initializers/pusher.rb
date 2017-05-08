# config/initializers/pusher.rb
require 'pusher'

Pusher.app_id = '336724'
Pusher.key = '85619837e880f6d5568c'
Pusher.secret = 'fb8cb17a3614b0bbf17a'
Pusher.logger = Rails.logger
Pusher.encrypted = true

# app/controllers/hello_world_controller.rb
class HelloWorldController < ApplicationController
  def hello_world
    Pusher.trigger('my-channel', 'my-event', {
      message: 'hello world'
    })
  end
end
