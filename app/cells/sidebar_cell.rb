class SidebarCell < Cell::Rails

  def search(args)
  	@home_user=args[:huser]
    @current_user=args[:cuser]
    @query_key=args[:query_key]
    render
  end
  def folders(args)
  	@home_user=args[:huser]
    @current_user=args[:cuser]
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
