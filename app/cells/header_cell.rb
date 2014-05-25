class HeaderCell < Cell::Rails

  def usertitle(args)
  	@home_user=args[:huser]
  	@current_user=args[:cuser]
    render
  end
  def commontitle(args)
  	@home_user=args[:huser]
  	@current_user=args[:cuser]
    render
  end

end
