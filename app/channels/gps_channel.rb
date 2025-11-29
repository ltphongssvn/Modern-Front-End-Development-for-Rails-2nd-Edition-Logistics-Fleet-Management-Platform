# app/channels/gps_channel.rb
class GpsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "gps_channel_#{params[:vehicle_id]}"
  end

  def unsubscribed
    stop_all_streams
  end
end
