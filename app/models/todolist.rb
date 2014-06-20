class Todolist
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  field :content
  field :startend
  field :start, :type => Date,:default => Date.today
  field :end, :type => Date,:default => Date.today
  field :done, :type => Boolean, :default => false
  field :sort, :type => Integer, :default => 0
  validates_presence_of :content,:start,:end
  belongs_to :user

  default_scope desc(:created_at)
  before_save do |todolist|
  	if todolist.startend.blank?
  		self.start=Date.today
  		self.end =Date.today 
  	else
  		begin
  			se = todolist.startend.split('-')
  			self.start=Date.strptime(se[0].strip, "%Y年%m月%d日")
  			self.end=Date.strptime(se[1].strip, "%Y年%m月%d日")
  		rescue 
  			errors.add('起止时间', '格式错误')
  			return false
  		end
  	end
    return true
  end
  def done?
    self.done
  end
  def get_color
    case (self.start-Date.today).to_f
    when 0...1
      'success'
    when 1...2
      'danger'
    when 2...6
      'warning'
    when 6...30
      'primary'
    when 30...9999999
      'info'
    else
      'default'
    end
  end
  def get_color_value
    case (self.start-Date.today).to_f
    when 0...1
      '#00a65a'
    when 1...2
      '#f56954'
    when 2...6
      '#f39c12'
    when 6...30
      '#0073b7'
    when 30...9999999
      '#00c0ef'
    else
      '#aaaaaa'
    end
  end
end
