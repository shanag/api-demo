class AppStatus < ActiveRecord::Base

  default_scope order('created_at DESC')
  
  attr_accessible :status, :message

  validates :status, :inclusion => {:in => %w(UP DOWN)}, :presence => true

end
