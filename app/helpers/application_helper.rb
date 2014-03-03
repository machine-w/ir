# -*- coding: utf-8 -*-
module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "学术交流平台"
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
  #显示提示信息
  def notice_message
    flash_messages = []

    flash.each do |type, message|
      case type
      when :notice
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
    when "documents"
      stylesheet_link_tag "documents"
    end
  end
  #添加每个控制器自己的脚本
  def controller_javascript_include_tag
    case controller_name
    when "users"
      javascript_include_tag controller_name
    when "documents"
      javascript_include_tag "documents"
    end
  end
end
