class FindAvailableRiderJob < ApplicationJob
  include ApplicationHelper
  queue_as :default

  def perform(store_latitude, store_longitude, checkout_seller)
    # query for available, nearest, and by batch

    # available riders
    unwanted_riders_ids = RiderTransaction.where(status: "Decline", checkout_seller_id: checkout_seller.id).pluck(:rider_id)
    available_riders_ids = Rider.where.not(id: unwanted_riders_ids).where(status: "On Shift").pluck(:id)

    # nearest riders
    store_coordinates = [store_latitude, store_longitude]
    distance = 10
    nearest_riders_ids = []

    while nearest_riders_ids.empty?
        nearest_riders_ids = Location.where(user_type: "Rider", user_id: available_riders_ids).near(store_coordinates, distance, units: :km).map(&:user_id)

        if nearest_riders_ids.empty?
            distance++
            sleep(10)
        end
    end

    # query by batch
    rider_id = nearest_riders_ids.first

    rider = Rider.find(rider_id)

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
  end
end
