module FoldersHelper
	def config_tab(index)
		script = "$(function(){$('#config_folder_nav > li').removeClass('active');\n" +
		         "$('#config_folder_nav > li:eq(#{index})').addClass('active');});"
		javascript_tag script
	end
end
