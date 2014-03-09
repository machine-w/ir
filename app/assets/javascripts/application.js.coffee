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

$ ->
	$('.form_w_val').validation(); #所有的form_w_val类的表单全部使用验证

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


