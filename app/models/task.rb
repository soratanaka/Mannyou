class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 140 }
  enum priority: { high: 0, middle: 1, low: 2}

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
