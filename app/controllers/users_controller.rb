class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    
      # GET /users
      # GET /users.json
      def index
        @users = User.all
      end
    
      # GET /users/1
      # GET /users/1.json
      def show
        @user = User.find(params[:id])
        if user_signed_in?
          if current_user.is_following?(params[:friend_id])
            Friend.where(user_id: current_user.id, friend_id: params[:friend_id]).delete_all
          else
            Friend.create(user_id: current_user.id, friend_id: params[:friend_id])
          end
        end
      end
    
      # GET /users/new
      def new
        @user = User.new(user_params)
      end
    
      # GET /users/1/edit
      def edit
      end

      def follow
        if current_user.is_following?(params[:friend_id])
          Friend.where(user_id: current_user.id, friend_id: params[:friend_id]).delete_all
        else
          Friend.create(user_id: current_user.id, friend_id: params[:friend_id])
        end
        redirect_to root_path
      end
    
      
      # PATCH/PUT /users/1
      # PATCH/PUT /users/1.json
      def update
        respond_to do |format|
          if @user.update(user_params)
            format.html { redirect_to @user, notice: 'User was successfully updated.' }
            format.json { render :show, status: :ok, location: @user }
          else
            format.html { render :edit }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
        end
      end
    
      # DELETE /users/1
      # DELETE /users/1.json
      def destroy
        @user.destroy
        respond_to do |format|
          format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
          format.json { head :no_content }
        end
      end
    
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_user
          @user = User.find(params[:id])
        end
    
        # Never trust parameters from the scary internet, only allow the white list through.
        def user_params
          params.require(:user).permit(:email, :password, :password_confirmation)
        end
    end