class SidebarCell < Cell::Rails

  def search(args)
  	@user=args[:user]
    render
  end
  def folders(args)
  	@user=args[:user]
    render
  end
  def tags(args)
  	@user=args[:user]
    render
  end

end
