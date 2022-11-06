class Task < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 140 }
  enum priority: { high: 0, middle: 1, low: 2}
  has_many :task_labels, dependent: :destroy, foreign_key: 'task_id'
  has_many :labels, through: :task_labels, source: :label

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

  # def find_label(id)
  #   @task_label = TaskLabel.where(task_id:id).select("label_id")
  #   @task_label.map do |a|
  #     @label_name = []
  #     @label_name.push(Label.where(id:a).select("name"))
  #   end
  # end
end
