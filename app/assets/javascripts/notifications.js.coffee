class Notifications
    constructor: ->
        @notifications = $("[data-behavior='notifications']")
        @setup() if @notifications.length > 0 

    setup: -> 
        $("[data-behavior='notifications-link']").on "click", @handleClick
        $("[data-behavior='ind-notification-link']").on "click", @handleClickInd
        $.ajax(
            url: "/notifications.json"
            dataType: "JSON"
            method: "GET"
            success: @handleSuccess
        )
        
    handleClick: (e) =>
        $.ajax(
            url: "/notifications/mark_as_read"
            dataType: "JSON"
            method: "POST"
            success: ->
                $("data-behavior='unread-count']").text(0)
        )

    handleClickInd: (e) =>
        $.ajax(
            url: "/notifications/:id/mark_as_read_ind"
            dataType: "JSON"
            method: "POST"
            success: ->
                $("[data-behavior='unread-count']").text(items.length)
        )

        
    handleSuccess: (data) =>
        items = $.map data, (notification) ->
            "<hr style='margin-top:2px;margin-bottom:10px;'><div style='margin-left:10px;'><img src='#{notification.useravatar}' style='width:50px;float:left;margin-right:10px;'> #{notification.actor} <a class='' href='#{notification.url}'>#{notification.action} the #{notification.type} for #{notification.areaname}</a> on #{notification.notifiable.date} at #{notification.notifiable.time}</div><br>"
        items.reverse()
        $("[data-behavior='unread-count']").text(items.length)
        $("[data-behavior='notification-items']").append(items)
        
        if items.length==0 then $("[data-behavior='notification-items']").append("<hr style='margin-top:2px;margin-bottom:10px;'><div style='width:100%;text-align:left;'>All caught up!</div>")

jQuery ->
    new Notifications