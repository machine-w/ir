$(function() {
    "use strict";
    /* For demo purposes */
    var demo = $("<div />").css({
        position: "fixed",
        top: "150px",
        right: "0",
        background: "rgba(0, 0, 0, 0.7)",
        "border-radius": "5px 0px 0px 5px",
        padding: "10px 15px",
        "font-size": "16px",
        "z-index": "999999",
        cursor: "pointer",
        color: "#ddd"
    }).html("<i class='fa fa-gear'></i>").addClass("no-print");

    var demo_settings = $("<div />").css({
        "padding": "10px",
        position: "fixed",
        top: "130px",
        right: "-200px",
        background: "#fff",
        border: "3px solid rgba(0, 0, 0, 0.7)",
        "width": "200px",
        "z-index": "999999"
    }).addClass("no-print");
    demo_settings.append(
            "<h4 style='margin: 0 0 5px 0; border-bottom: 1px dashed #ddd; padding-bottom: 3px;'>视图选项</h4>"
            + "<div class='form-group no-margin'>"
            + "<div class='.checkbox'>"
            + "<label>"
            + "<input type='checkbox' id='fixview_fix_header' onchange='fix_header();'/> "
            + "固定导航条"
            + "</label>"
            + "</div>"
            + "<div class='.checkbox'>"
            + "<label>"
            + "<input type='checkbox' id='fixview_switch_pubu' onchange='switch_pubu();'/> "
            + "瀑布流显示"
            + "</label>"
            + "</div>"
            + "</div>"
            );

    demo.click(function() {
        if (!$(this).hasClass("open")) {
            $(this).css("right", "200px");
            demo_settings.css("right", "0");
            $(this).addClass("open");
        } else {
            $(this).css("right", "0");
            demo_settings.css("right", "-200px");
            $(this).removeClass("open");
        }
    });

    $("body").append(demo);
    $("body").append(demo_settings);
    if ($("body").data('viewpubu')+'' == 'pubu') {
        $("#fixview_switch_pubu").attr("checked", true);
    }

    if ($("body").data('fixheader')+'' == 'true') {
        $("#fixview_fix_header").attr("checked", true);
        //alert($("body").data('fixheader'));
        $("body").addClass("fixed");
    }
    else
    {
        $("#fixview_fix_header").attr("checked", false);
        $("body").removeClass("fixed");
    }

});
function fix_header() {
    $("body").toggleClass("fixed");
    $.post(
        '/fixview/fixheader.json',
        {
          fixheader: $("#fixview_fix_header").prop( "checked" )+''
        }
      );
}
function switch_pubu() {
    $.post(
        '/fixview/pubu.json',
        {
          pubu: $("#fixview_switch_pubu").prop( "checked" )+''
        },
        function(data) {
            window.location.reload();
        }
      );
}
function copy_document(url,id) {
    $.ajax({
        url: url,
        type: "post",
        data: {doc_id: id},
        success: function(result) {
            if (result['status'] === 'true') {
                Messenger().post({
                    message: result['message'],
                    type: 'success',
                    showCloseButton: true
                });
            } else {
                Messenger().post({
                    message: result['message'],
                    type: 'error',
                    showCloseButton: true
                });
            }
        }
    });
    return true;
}