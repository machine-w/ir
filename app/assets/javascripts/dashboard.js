/*
 * Author: Abdullah A Almsaeed
 * Date: 4 Jan 2014
 * Description:
 *      This is a demo file used only for the main dashboard (index.html)
 **/

$(function() {
    "use strict";
    //Make the dashboard widgets sortable Using jquery UI
    $(".connectedSortable").sortable({
        placeholder: "sort-highlight",
        connectWith: ".connectedSortable",
        handle: ".box-header, .nav-tabs, .inner",
        forcePlaceholderSize: true,
        dropOnEmpty: true,
        zIndex: 999999
    }).disableSelection();
    $(".box-header, .nav-tabs").css("cursor","move");
    //jQuery UI sortable for the todo list
    $(".todo-list").sortable({
        placeholder: "sort-highlight",
        handle: ".handle",
        forcePlaceholderSize: true,
        zIndex: 999999
    }).disableSelection();;
    function build_calendar(view_done) {
        $.ajax({
            url: $('#calendar').data('url'),
            type: 'get',
            data: {},
            success: function(data) {
                var events=[];
                var done_color;
                $.each(data, function(index, value) {
                    done_color= (value['done'] == true)? '#dddddd' : value['get_color_value'];
                    if (view_done || value['done'] != true) {
                        events.push({
                            title: value['content'],
                            start: new Date(Date.parse(value['start'].replace(/-/g,"/"))),
                            end: new Date(Date.parse(value['end'].replace(/-/g,"/"))),
                            backgroundColor: done_color, 
                            borderColor: value['get_color_value'] 
                        });
                    }
                });
                $('#calendar').fullCalendar( 'destroy' );
                $('#calendar').fullCalendar({
                    //editable: true, //Enable drag and drop
                    events: events,
                    buttonText: {//This is to add icons to the visible buttons
                        prev: "<span class='fa fa-caret-left'></span>",
                        next: "<span class='fa fa-caret-right'></span>",
                        today: '今天',
                        month: '月',
                        week: '星期',
                        day: '天'
                    },
                    header: {
                        left: 'today',
                        center: 'title',
                        right: 'prev,next'
                        //right: 'month,agendaWeek,agendaDay'
                    }
                });
            },
            error: function(){  
                $('#calendar').fullCalendar({
                    buttonText: {//This is to add icons to the visible buttons
                        prev: "<span class='fa fa-caret-left'></span>",
                        next: "<span class='fa fa-caret-right'></span>",
                        today: '今天',
                        month: '月',
                        week: '星期',
                        day: '天'
                    },
                    header: {
                        left: 'title',
                        center: '',
                        right: 'prev,next'
                    }
                });
            }  
        });
    }
    build_calendar(true);
    $("#calendar-view-done").click(function(){
      build_calendar(true);
    });
    $("#calendar-no-done").click(function(){
      build_calendar(false);
    });
    /* The todo list plugin */
    $(".todo-list").todolist({

        onCheck: function(ele) {
            $("#calendar-view-done").hasClass("active") ? true : false
            build_calendar($("#calendar-view-done").hasClass("active") ? true : false);
            //console.log(jQuery.type($(ele))+"The element has been checked")
        },
        onUncheck: function(ele) {
            build_calendar($("#calendar-view-done").hasClass("active") ? true : false);
            //console.log("The element has been unchecked")
        }
    });
});