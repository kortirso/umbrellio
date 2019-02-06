module Api
  module V1
    class PostsController < Api::V1::BaseController
      before_action :take_best_posts, only: %i[top]
      before_action :extract_ips, only: %i[ips_with_users]

      def create
        handler = PostHandler.new(post_params, user_params)
        if handler.valid?
          post = handler.call
          render json: post, serializer: PostSerializer, status: 201
        else
          render json: { errors: handler.errors.full_messages }, status: 422
        end
      end

      def top
        render json: @posts, status: 200
      end

      def ips_with_users
        render json: { ips_with_users: @result }, status: 200
      end

      private

      def take_best_posts
        @posts = Post.order(average_rate: :desc).first(params[:n].to_i)
      end

      def extract_ips
        @result = Post.ips_with_users.group_by { |x| x[0] }.map { |key, value| { key => value.map { |x| x[1] }.flatten } }
      end

      def post_params
        params.require(:post).permit(:title, :content, :author_ip)
      end

      def user_params
        params.require(:user).permit(:username)
      end
    end
  end
end
