class NotificationsController < ApplicationController
    before_action :authenticate_user!
    
    def index 
        #@notifications = Notification.where(recipient: current_user).unread
        @notifications = Notification.where(recipient: current_user).unread
        @notificationsall = Notification.where(recipient: current_user)
        @notificationspaginated = @notificationsall.paginate(:page => params[:page], :per_page => 25).order('id DESC')
        #rescue ActiveRecord::RecordNotFound
        #  redirect_to(root_url, :notice => 'Record not found')
    end 
    
    def mark_as_read
        @notifications = Notification.where(recipient: current_user).unread
        @notifications.update_all(read_at: Time.zone.now)
        render json: {success: true}
    end
    
    #going to need something like this
    def mark_as_read_ind
        @notification = Notification.find(:id)
        @notification.update(read_at: Time.zone.now)
        render json: {success: true}
    end
end