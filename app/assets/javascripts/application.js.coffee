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
	# 所有sel_color类的录入框全都选颜色
	$(".sel_color").colorpicker();
	# 所有sel_date类的录入框全都选日期
	$('.sel_date').datepicker({language: 'zh-CN',todayHighlight: true});
	$(".datepicker").css("z-index", "9999");
	# 所有sel_time类的录入框全都选时间
	$('.sel_time').clockface({});
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


