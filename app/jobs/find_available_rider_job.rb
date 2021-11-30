class FindAvailableRiderJob < ApplicationJob
  include ApplicationHelper
  queue_as :default

  def perform(store_latitude, store_longitude, checkout_seller)
    distance = 10
    is_continue = true 
    nearest_riders_ids = []
    time = 1

    while is_continue
      # query for available, nearest, and by batch

      # available riders
      unwanted_riders_ids = RiderTransaction.where(status: "Decline", checkout_seller_id: checkout_seller.id).pluck(:rider_id)
      available_riders_ids = Rider.where.not(id: unwanted_riders_ids).where(status: "On Shift").pluck(:id)

      # nearest rider
      store_coordinates = [store_latitude, store_longitude]
      loc_of_nearest_rider = Location.where(user_type: "Rider", user_id: available_riders_ids).near(store_coordinates, distance, units: :km).first

      if loc_of_nearest_rider.present?
        rider = loc_of_nearest_rider.user
        is_continue = false
        
        # update rider's availability
        rider.update(status: 5) # Pending Order
        rider.reload

        checkout_seller.update(rider_id: rider.id)
        checkout_seller.reload

        # websocket to rider
        data = {
          transaction: ApplicationController.helpers.current_transaction_info(checkout_seller)
        }
        channel = "rider_transaction_#{rider.id}"
        ApplicationController.helpers.broadcast(channel, data)
      else
        # Max distance is 15 km
        if distance < 15
          distance += 1
        end

        # Max time for finding rider is 60seconds
        if time >= 60
          checkout_seller.update(enqueued_time: Time.now)
          checkout_seller.reload
          # broadcast to admin website and stop loop
          is_continue = false
        else
          # 1 second
          sleep(1) 
          time += 1
        end
      end
    end
  end
end
