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

  default_scope asc(:created_at)
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
end
