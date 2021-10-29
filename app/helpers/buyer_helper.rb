module BuyerHelper
    def find_available_rider(store_latitude, store_longitude)
        # query for available, nearest, and by batch

        # available riders
        available_riders_ids = Rider.where(is_available: true).pluck(:id)

        # nearest riders
        store_coordinates = [store_latitude, store_longitude]
        distance = 5
        nearest_riders_ids = []

        while nearest_riders_ids.empty?
            nearest_riders_ids = Location.where(user_type: "Rider", user_id: available_riders).near(store_coordinates, distance, units: :km).map(&:user_id)

            if nearest_riders_ids.empty?
                distance++
                sleep(10)
            end
        end

        # query by batch
        rider_id = nearest_riders_ids.first

        rider = Rider.find(rider_id)

        # update rider's availability
        rider.update(is_available: false)
        rider.reload

        return rider
    end
end
