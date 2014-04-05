$ ->
  # to set summernote object
   summer_note = $('#document_content_have_attr')
   summer_note.summernote
     height: ($(window).height() - 500),
     lang: 'zh-CN',
     style: 'cosmo'
   summer_note.code summer_note.val()
   summer_note.closest('form').submit ->
     summer_note.val summer_note.code()
     true