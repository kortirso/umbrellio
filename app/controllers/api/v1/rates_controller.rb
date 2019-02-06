module Api
  module V1
    class RatesController < Api::V1::BaseController
      def create
        handler = RateHandler.new(rate_params)
        if handler.valid?
          result = handler.call
          render json: { post_average_rate: result.average_rate / 100.0 }, status: 200
        else
          render json: { errors: handler.errors.full_messages }, status: 422
        end
      end

      private

      def rate_params
        params.require(:rate).permit(:post_id, :value)
      end
    end
  end
end
