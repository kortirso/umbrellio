module Api
  module V1
    class RatesController < Api::V1::BaseController
      before_action :find_post, only: %i[create]

      def create
        rate_form = RateForm.new(rate_params.merge(post: @post))
        if rate_form.persist?
          result = UpdatePostRates.call(post: @post, value: rate_form.rate.value)
          render json: { post_average_rate: result.average_rate / 100.0 }, status: 200
        else
          render json: { errors: rate_form.errors.full_messages }, status: 422
        end
      end

      private

      def find_post
        @post = Post.find_by_id(params[:post_id])
        render json: { errors: ['Post is not found'] }, status: 404 if @post.nil?
      end

      def rate_params
        params.require(:rate).permit(:value)
      end
    end
  end
end
