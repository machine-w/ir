$ ->
  # to set summernote object
  summer_note = $('#document_content_have_attr')
  summer_note.summernote
    height: ($(window).height() - 500),
    lang: 'zh-CN',
    style: 'cosmo',
    focus: true,
    oninit: ->
      insertBtn = "<button id='insertTagBtn' data-toggle='modal' data-target='#insert-property-modal' type='button' class='btn btn-primary btn-sm btn-small' title='插入属性' data-event='something' tabindex='-1'><i class=' fa fa-gears'></i></button>"
      partiBtn =  "<button id='insertPartitonBtn' type='button' class='btn btn-default btn-sm btn-small' title='' data-event='something' tabindex='-1'><i class=' fa fa-cut'></i></button>"
      fileGroup = "<div class=\"note-property btn-group\">" + insertBtn + partiBtn + "</div>"
      $(fileGroup).prependTo $(".note-toolbar")
      $("#insertTagBtn").tooltip
        container: "body"
        placement: "bottom"
      $("#insertPartitonBtn").tooltip
        container: "body"
        placement: "bottom"
      $('#insertPartitonBtn').click ->
        if !$('#summary_line')[0]
          document.execCommand('insertHTML',false,'&nbsp;<button id=\'summary_line\' type=\'button\' class=\'btn btn-default btn-sm has_tooltip\' data-toggle=\'tooltip\' data-placement=\'top\' title=\'摘要分割点\'><i class=\'fa fa-angle-double-right\'></i></button>&nbsp;');
          $('#summary_line').tooltip();
      return
  summer_note.code summer_note.val()
  summer_note.closest('form').submit ->
    summer_note.val summer_note.code()
    true