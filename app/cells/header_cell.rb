class HeaderCell < Cell::Rails

  def usertitle(args)
  	@home_user=args[:huser]
  	@current_user=args[:cuser]
    render
  end
  def commontitle(args)
  	@home_user=args[:huser]
  	@current_user=args[:cuser]
    @query_key=args[:query_key]
    @ddg_name =args[:ddg_name]
    render
  end

end
