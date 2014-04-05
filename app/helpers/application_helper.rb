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
    page_name.empty? ? "标题" : page_name
  end
  # 返回页面名称
  def show_page_summary(page_summary)
    page_summary.empty? ? "无详细信息" : page_summary
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
  #新的提示信息函数（使用messanger）
  def notice_message_with_js
   flash_messages = []
  if devise_controller?
     unless resource.errors.empty?
      error_msg = ""
      resource.errors.full_messages.each do |msg| 
        error_msg += "#{msg}|"
      end
      flash.now['error']=error_msg
    end
  end
  flash.each do |type, message|
    case type
    when :notice,:success
      view_type = :success
    when :alert,:error
      view_type = :error
    else
      view_type = :info
    end
    text = <<EOF
    Messenger().post({
      message: \'#{message}\',
      type: \'#{view_type}\',
      showCloseButton: true
      });
EOF
flash_messages << text if message
end
javascript_tag flash_messages.join("\n")
end

  #添加每个控制器自己的样式表
  def controller_stylesheet_link_tag
    case controller_name
    when "users"
      stylesheet_link_tag controller_name
    else
      stylesheet_link_tag "admin/"+controller_name
    end
  end
  #添加每个控制器自己的脚本
  def controller_javascript_include_tag
    case controller_name
    when "users"
      javascript_include_tag controller_name
    else
      javascript_include_tag "admin/"+controller_name
    end
  end
end
