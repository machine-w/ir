# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery-min
#= require jquery_ujs
# Loads all Bootstrap javascripts
#= require bootstrap
#= require jquery.ui.all
# load pace 
#= require pace/pace
# load validation tool
#= require bootstrap3-validation
# load messanger
#= require messenger
#= require messenger-theme-future
# load confirm
#= require data-confirm-modal
# load inputmask
#= require jquery.inputmask
#= require jquery.inputmask.extensions
#= require jquery.inputmask.numeric.extensions
#= require jquery.inputmask.date.extensions
# load colorpicker
#= require bootstrap-colorpicker
# load datepicker
#= require bootstrap-datepicker/core
#= require bootstrap-datepicker/locales/bootstrap-datepicker.zh-CN
# load summernote
#= require summernote.min
#= require lang/summernote-zh-CN
# load clockface
#= require clockface/clockface
# load handsontable
#= require handsontable/jquery.handsontable.full
# load typeahead
#= require handlebars
#= require twitter/typeahead.min
# load websocket
#= require websocket_rails/main
#
#= require socket
##############################从admincommon移过来
#= require iCheck/icheck.min
#= require bootstrap-select
#= require select2
#= require select2_locale_zh-CN
#= require tagmanager
#= require switch/bootstrap-switch.min
###############################
#背景图片插件
#= require jquery.backstretch.min
#无限下拉
#= require jquery.infinitescroll.min
#瀑布流
#= require masonry.pkgd.min
#= require imagesloaded.pkgd.min
#pdfobject
#= require pdfobject.min
#fileinput
#= require fileinput.min

format = (state) ->
	originalOption = state.element;
	"<img class='flag' width='100' src='" + $(originalOption).data('img') + "'/>" + state.text
$ ->
	fill_array_options = (arg) ->
    if(arg.attr('value')=='[]')
        arg.val("")
        return []
    else
        JSON.parse(arg.attr('value'))
	$('.form_w_val').validation(); #所有的form_w_val类的表单全部使用验证
	# 所有的类型为下类的录入框都验证
	$('.inputmask').inputmask();
	$('.inputnumber').inputmask("integer");
	$('.inputdecimal').inputmask("decimal");
	# 设置选择框（admincommon移过来）
	$('.select2').select2({allowClear: true,width: 'resolve'});
	$('.select2-with-pic').select2({formatResult: format,formatSelection: format});
	# 所有sel_color类的录入框全都选颜色
	$(".sel_color").colorpicker();
	# 所有sel_date类的录入框全都选日期
	$('.sel_date').datepicker({language: 'zh-CN',todayHighlight: true});
	# input-daterange选择日期范围
	$('.input-daterange').datepicker({language: 'zh-CN',todayHighlight: true});
	$(".datepicker").css("z-index", "9999");
	# 所有sel_time类的录入框全都选时间
	$('.sel_time').clockface({});
	$("#user_avatar").fileinput
		showUpload: false
		browseLabel: "上传头像"
		showRemove: false
		initialCaption: "当前头像"
		#showCaption: false
		browseClass: "btn btn-success"
		initialPreview: ["<img src='"+$("#user_avatar").data('avatar')+"' class='file-preview-image'>"]
	$(".input-picture").each ->
		if $(this).data('pic') == ''
			preview = ["<div class='file-preview-text'><h2><i class='fa fa-square-o'></i></h2>尚未上传图片</div>"]
		else
			preview = ["<img src='"+$(this).data('pic')+"' class='file-preview-image'>"] 
		$(this).fileinput
			showUpload: false
			browseLabel: $(this).data('name')
			browseIcon: "<i class='fa fa-picture-o'></i>"
			showRemove: false
			initialCaption: $(this).data('size')
			#showCaption: false
			browseClass: "btn btn-success"
			initialPreview: preview
	$(".input-pdf").each ->
		if $(this).data('pdf') == ''
			preview = ["<div class='file-preview-text'><h2><i class='fa fa-file-text-o'></i></h2>尚未上传pdf文件</div>"]
		else
			preview = ["<div class='file-preview-text'><a href='" + $(this).data('url') + "'><h2><i class='fa fa-file-text'></i></h2>" + $(this).data('pdf') + "</a></div>"] 
		$(this).fileinput
			showUpload: false
			browseLabel: $(this).data('name')
			browseIcon: "<i class='fa fa-file-text'></i>"
			showRemove: false
			initialCaption: $(this).data('size')
			#showCaption: false
			browseClass: "btn btn-success"
			initialPreview: preview
	$(".input-file").each ->
		if $(this).data('file') == ''
			preview = ["<div class='file-preview-text'><h2><i class='fa fa-file-o'></i></h2>尚未上传文件</div>"]
		else
			preview = ["<div class='file-preview-text'><a href='" + $(this).data('url') + "'><h2><i class='fa fa-file'></i></h2>" + $(this).data('file') + "</a></div>"] 
		$(this).fileinput
			showUpload: false
			browseLabel: $(this).data('name')
			browseIcon: "<i class='fa fa-file'></i>"
			showRemove: false
			initialCaption: $(this).data('size')
			#showCaption: false
			browseClass: "btn btn-success"
			initialPreview: preview
	$(".input-video").each ->
		if $(this).data('video') == ''
			preview = ["<div class='file-preview-text'><h2><i class='fa fa-youtube-play'></i></h2>尚未上传视频</div>"]
		else
			#preview = ["<div class='file-preview-text'><a href='" + $(this).data('url') + "'><h2><i class='fa fa-video-camera'></i></h2>" + $(this).data('video') + "</a></div>"] 
			preview = ["<video src='"+$(this).data('url')+"?random="+$(this).data('random')+"' controls='controls' class='small-video'>你的浏览器不支持播放视频,<a href='"+$(this).data('url')+"'>点击下载</a></video>"] 
		$(this).fileinput
			showUpload: false
			browseLabel: $(this).data('name')
			browseIcon: "<i class='fa fa-video-camera'></i>"
			showRemove: false
			initialCaption: $(this).data('size')
			#showCaption: false
			browseClass: "btn btn-success"
			initialPreview: preview
	$(".input-music").each ->
		if $(this).data('music') == ''
			preview = ["<div class='file-preview-text'><h2><i class='fa fa-headphones'></i></h2>尚未上传音频</div>"]
		else
			#preview = ["<div class='file-preview-text'><a href='" + $(this).data('url') + "'><h2><i class='fa fa-video-camera'></i></h2>" + $(this).data('video') + "</a></div>"] 
			preview = ["<audio controls><source src='"+$(this).data('url')+"'>你的浏览器不支持播放音频,<a href='"+$(this).data('url')+"'>点击下载</a></audio>"] 
		$(this).fileinput
			showUpload: false
			browseLabel: $(this).data('name')
			browseIcon: "<i class='fa fa-music'></i>"
			showRemove: false
			initialCaption: $(this).data('size')
			#showCaption: false
			browseClass: "btn btn-success"
			initialPreview: preview
	$(".tags").each ->
		$(this).tagsManager({prefilled: fill_array_options($(this))})
	$('.summernote-input').each ->
		$(this).summernote
   			lang: 'zh-CN'
   		$(this).code $(this).val()
   		this_summernote = $(this)
   		$(this).closest('form').submit ->
   			this_summernote.val this_summernote.code()
   			true
   		return

	# to set handsontable
	get_array_data = (data,rows,cols) ->
    arr = []
    i = 0
    while i < rows
      arr2 = []
      j = 0
      while j < cols
      	arr2.push(data[i*cols+j]) #第j个单元格推入数组中保存
      	j++
      arr.push arr2
      i++
    return arr
	$(".handsontable-input").each ->
		rows = $(this).next().val()
		cols = $(this).next().next().val()
		data_array =  JSON.parse($(this).next().next().next().val())
		$(this).handsontable({data: get_array_data(data_array,rows,cols),startRows: rows,startCols: cols});
		table_data = $(this).data('handsontable');
		this_handsontable = $(this)
		$(this).closest('form').submit ->
	    	this_handsontable.prev().val table_data.getData()
	     true
	$(".handsontable-view").each ->
		rows = $(this).next().val()
		cols = $(this).next().next().val()
		data_array =  JSON.parse($(this).next().next().next().val())
		$(this).handsontable
		  data: get_array_data(data_array,rows,cols),
		  startRows: rows,
		  startCols: cols,
		  cells: (r, c, prop) ->
		  	{readOnly:true}

	#设置提示信息的位置和样式
	#Messenger.options = {
    #extraClasses: 'messenger-fixed messenger-on-top',
    #theme: 'block'
    #}

    #设置确认框的标题和按钮
	dataConfirmModal.setDefaults
	  title: "你确定吗？"
	  commit: "继续"
	  cancel: "取消"


	$('.view-pdf').each ->
	   	pdf= new PDFObject({ url: $(this).data('url'),pdfOpenParams: {navpanes: 1,toolbar: 0,statusbar: 0,view: "FitV"} }).embed($(this).attr('id'))
	   	#alert $(this).attr('id')
	   	true


