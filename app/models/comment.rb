class Comment < ActiveRecord::Base
  belongs_to :app
  belongs_to :user

  default_scope -> { order('created_at DESC') }

  #validates :comment, :presence => true,length: { maximum: 2000 }

end
