$ ->
  # to set summernote object
  summer_note = $('#document_content_have_attr')

  # to call summernote editor
  summer_note.summernote
    # to set options
    height: ($(window).height() - 450),
    #lang: 'ko-KR',
    style: 'cosmo'
    # toolbar: [
                # ['insert', ['picture', 'link']], // no insert buttons
                # ["table", ["table"]],
                # ["style", ["style"]],
                # ["fontsize", ["fontsize"]],
                # ["color", ["color"]],
                # ["style", ["bold", "italic", "underline", "clear"]],
                # ["para", ["ul", "ol", "paragraph"]],
                # ["height", ["height"]],
                # ["help", ["help"]]
             # ]


  # to set code for summernote
  summer_note.code summer_note.val()

  # to get code for summernote
  summer_note.closest('form').submit ->
    # alert $('#post_content').code()
    summer_note.val summer_note.code()
    true