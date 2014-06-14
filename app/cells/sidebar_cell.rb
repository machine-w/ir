class SidebarCell < Cell::Rails

  def userinfo(args)
    @home_user=args[:huser]
    @current_user=args[:cuser]
    @query_key=args[:query_key]
    render
  end
  def search(args)
  	@home_user=args[:huser]
    @current_user=args[:cuser]
    @query_key=args[:query_key]
    render
  end
  def folders(args)
  	@home_user=args[:huser]
    @current_user=args[:cuser]
    @cur_folder= args[:cur_folder]
    @public_folders=@home_user.folders.all.entries.find_all{|n| n.visiable?(@current_user) } if @home_user
    render
  end
  def topdocs(args)
    @home_user=args[:huser]
    @current_user=args[:cuser]
    render
  end
  def topusers(args)
    @home_user=args[:huser]
    @current_user=args[:cuser]
    render
  end
  def tags(args)
  	@home_user=args[:huser]
    @current_user=args[:cuser]
    render
  end

end
