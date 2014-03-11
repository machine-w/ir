class Admin::PropertiesController < ApplicationController
	before_filter :authenticate_user!
	before_filter :set_user
	before_filter :set_folder, only: [:create,:update,:destroy]
	layout "admin_layout"
	def create
		@property = @folder.properties.build(properties_params)
		if params.has_key?('addhidden-property')
			@property.enum_option=add_tags_params['enum_option'].split(',') if add_tags_params.has_key?('enum_option')
			@property.file_type=add_tags_params['file_type'].split(',') if add_tags_params.has_key?('file_type')
		end 
		error_msg='错误：'
		if @property.save
			flash[:success] = "新建属性成功"
		else
			@property.errors.full_messages.each do |msg|
				error_msg += msg + ','
			end
			flash[:error]=error_msg
		end
		redirect_to config_property_admin_folder_path(@folder)
	end
	def update
		@property=@folder.properties.find(params[:id])
		error_msg='错误：'
		if params.has_key?('hidden-property')
			@property.enum_option=tags_params['enum_option'].split(',') if tags_params.has_key?('enum_option')
			@property.file_type=tags_params['file_type'].split(',') if tags_params.has_key?('file_type')
		end 
		if @property.update_attributes!(properties_params)
			flash[:success] = "修改属性成功"
		else
			@property.errors.full_messages.each do |msg|
   				error_msg += msg + ','
   			end
   			flash[:error]=error_msg
		end
		redirect_to config_property_admin_folder_path(@folder)
	end
	def destroy
		@property=@folder.properties.find(params[:id])
		#@property=Property.find(params[:id])
		@property.destroy
		redirect_to config_property_admin_folder_path(@folder)
	end
	private 
	def set_folder
		@folder = @user.folders.find(params[:folder_id])
	end
	def properties_params
		params.require(:property).permit(:name,:show_name,:type,:require,:static,:view_in_grid,:onlyread,:disable,:description,:max_value,:min_value,:front_ext,:back_ext,:string_format,:data_x,:data_y)
	end
	def add_tags_params
		params.require("addhidden-property").permit(:enum_option,:file_type)
	end
	def tags_params
		params.require("hidden-property").permit(:enum_option,:file_type)
	end
end
