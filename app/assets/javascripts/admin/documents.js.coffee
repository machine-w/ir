$ ->
  # to set summernote object
  summer_note = $('#document_content_have_attr')
  summer_note.summernote
    height: ($(window).height() - 500),
    lang: 'zh-CN',
    style: 'cosmo',
    focus: true,
    oninit: ->
      insertBtn = "<button id='insertTagBtn' data-toggle='modal' data-target='#insert-property-modal' type='button' class='btn btn-info btn-sm btn-small' title='插入属性' data-event='something' tabindex='-1'><i class=' fa fa-gears'></i></button>"
      fileGroup = "<div class=\"note-property btn-group\">" + insertBtn + "</div>"
      $(fileGroup).prependTo $(".note-toolbar")
      $("#insertTagBtn").tooltip
        container: "body"
        placement: "bottom"
      return
  summer_note.code summer_note.val()
  summer_note.closest('form').submit ->
    summer_note.val summer_note.code()
    true