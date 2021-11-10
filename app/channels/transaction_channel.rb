class TransactionChannel < ApplicationCable::Channel
    rescue_from StandardError, with: :deliver_error_message

    def subscribed
        stream_from "transaction"
    end

    private

    def deliver_error_message(e)
        # broadcast_to(...)
        puts e
    end
end