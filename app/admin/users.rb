ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment

  permit_params :username, :image, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at
    index do
      selectable_column
      column :username
      column :email
      column :sign_in_count
      column :created_at
      column :tweet_count do |user|
        columns user.tweets.count
      end
      column :likes_count do |user|
        columns user.likes.count
      end
      column :follow_count do |user|
        columns user.friends.count
      end
      column :retweet_count do |user|
        columns user.tweets.pluck(:rt_ref).compact!.count
      end
      actions
    end
    # or
    #
    # permit_params do
    #   permitted = [:name, :image, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
    #   permitted << :other if params[:action] == 'create' && current_user.admin?
    #   permitted
    # end
    

  
end
