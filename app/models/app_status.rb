class AppStatus < ActiveRecord::Base

  attr_accessible :status, :message

  validates :status, :inclusion => {:in => %w(UP DOWN)}, :presence => true

end
