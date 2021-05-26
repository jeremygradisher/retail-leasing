json.array! @notifications do |notification| 
    json.id notification.id
    json.recipient notification.recipient.id
    
    if notification.actor != nil
      json.actor notification.actor.first_name + ' ' +notification.actor.last_name
      if notification.actor.user_avatars.first.present?
        json.useravatar notification.actor.user_avatars.first.avatar.url
      else
        json.useravatar "/images/NO-IMAGE-AVAILABLE.jpg"
      end
    else
      json.actor '(Deleted User)'
      json.useravatar "/images/NO-IMAGE-AVAILABLE.jpg"
    end

    json.action notification.action 
    
    json.type "#{notification.notifiable_type.underscore.humanize.downcase}"

    json.read_at notification.read_at
    
    #json.notifiable notification.notifiable 
    json.notifiable do notification.notifiable
        #json.type "#{notification.notifiable.class.to_s.underscore.humanize.downcase}"
        json.date "#{notification.created_at.strftime('%a %b %d, %Y')}"
        json.time "#{notification.created_at.in_time_zone('Eastern Time (US & Canada)').strftime('%I:%M %p')}"
    end
    
    
    
    if notification.notifiable != nil
      if notification.notifiable_type.underscore.humanize.downcase == "area"
        #json.areaname 'logic change'
        json.areaname notification.notifiable.suite_number
        json.url area_path(notification.notifiable.id)
      elsif notification.notifiable_type.underscore.humanize.downcase == "map"
        json.areaname notification.notifiable.name
        json.url map_path(notification.notifiable.id)
      elsif notification.notifiable_type.underscore.humanize.downcase == "project"
        json.areaname notification.notifiable.name
        json.url project_path(notification.notifiable.id)
      elsif notification.notifiable_type.underscore.humanize.downcase == "deal"
        json.areaname notification.notifiable.deal_name
        json.url project_path(notification.notifiable.id)
      elsif notification.notifiable_type.underscore.humanize.downcase == "workletter"
        json.areaname notification.notifiable.name
        json.url project_path(notification.notifiable.id)
      elsif notification.notifiable_type.underscore.humanize.downcase == "schedule"
        json.areaname notification.notifiable.deal_id
        json.url project_path(notification.notifiable.id)
      else
        json.areaname notification.notifiable.area.name
        json.url area_path(notification.notifiable.area_id)
      end
    else
      if notification.notifiable_type.underscore.humanize.downcase == "area"
        json.areaname '(Deleted Area)'
        json.url notifications_path()
      elsif notification.notifiable_type.underscore.humanize.downcase == "map"
        json.areaname '(Deleted Map)'
        json.url notifications_path()
      elsif notification.notifiable_type.underscore.humanize.downcase == "project"
        json.areaname '(Deleted Project)'
        json.url notifications_path()
      elsif notification.notifiable_type.underscore.humanize.downcase == "workletter"
        json.areaname '(Deleted Workletter)'
        json.url notifications_path()
      elsif notification.notifiable_type.underscore.humanize.downcase == "deal"
        json.areaname '(Deleted Deal)'
        json.url notifications_path()
      elsif notification.notifiable_type.underscore.humanize.downcase == "schedule"
        json.areaname '(Deleted Schedule)'
        json.url notifications_path()
      else
        json.areaname '(Deleted Something)'
        json.url notifications_path()
      end
    end

    #json.url area_path(notification.notifiable.area_id, anchor: dom_id(notification.notifiable)) 
    #json.url area_path(notification.notifiable.area_id)
end 