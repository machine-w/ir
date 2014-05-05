#= require jquery-min
#= require jquery_ujs
# Loads all Bootstrap javascripts
#= require bootstrap
#= require jquery.ui.all
# load validation tool
#= require bootstrap3-validation
#= require iCheck/icheck.min
#= require app


$ ->
	$('.form_w_val').validation(); #所有的form_w_val类的表单全部使用验证