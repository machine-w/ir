#= require iCheck/icheck.min
#= require bootstrap-select
#= require select2
#= require select2_locale_zh-CN
#= require switch/bootstrap-switch.min
#= require tagmanager
#= require app

$ -> 
	$('.select2').select2({allowClear: true});
	$('.switch').bootstrapSwitch();
	