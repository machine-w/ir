# -*- coding: utf-8 -*-
module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "TJU IR"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  # 返回页面的背景皮肤.
  def bg_skin(bgclass)
    base_class = ""
    if bgclass.empty?
      base_class
    else
      bgclass
    end
  end
  # 返回页面名称
  def show_page_name(page_name)
    page_name.empty? ? "仪表盘" : page_name
  end
  # 返回页面名称
  def show_page_summary(page_summary)
    page_summary.empty? ? "后台管理界面" : page_summary
  end
  #显示提示信息
  def notice_message
    flash_messages = []

    flash.each do |type, message|
      case type
      when :notice,:success
        view_type = :success
        icon = :check
      when :alert
        view_type = :danger
        icon = :ban
      else
        view_type = :info
        icon = :info
      end
      text = content_tag(:div, content_tag(:i, nil, class: "fa fa-#{icon}")+
        content_tag(:button,"x",class: "close",'data-dismiss'=> "alert",'aria-hidden'=>"true") +
        #link_to("x", "#", :class => "close", 'data-dismiss' => "alert") + 
        message, :class => "alert alert-#{view_type} alert-dismissable")
      flash_messages << text if message
    end

    flash_messages.join("\n").html_safe
  end
  #添加每个控制器自己的样式表
  def controller_stylesheet_link_tag
    case controller_name
    when "users"
      stylesheet_link_tag controller_name
    when "folders"
      stylesheet_link_tag "admin/folders"
    else
      stylesheet_link_tag controller_name
    end
  end
  #添加每个控制器自己的脚本
  def controller_javascript_include_tag
    case controller_name
    when "users"
      javascript_include_tag controller_name
    when "folders"
      javascript_include_tag "admin/folders"
    else
      javascript_include_tag controller_name
    end
  end
end
