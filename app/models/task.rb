class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 140 }

  def self.looks(status, word)
    if word.present? && status == "unselected"
      @tasks = Task.where("name LIKE?","%#{word}%")
    elsif word.present? && status != "unselected"
      @tasks = Task.where("name LIKE?","%#{word}%").where(status: status)
    elsif status != "unselected"
      @tasks = Task.where(status: status)
    else
      @tasks = Task.all
    end
  end
end
