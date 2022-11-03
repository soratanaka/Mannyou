class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.user_tasks(id)
    @tasks = Task.where(user_id:id)
  end

  def self.user_fix(id)
    if User.find(id).admin
      User.find(id).password_digest
    end
  end
end
