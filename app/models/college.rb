class College < ActiveRecord::Base
  belongs_to :state
  belongs_to :category
  default_scope joins(:state).order("states.name, colleges.name")
  
  
  validates_presence_of :name, :state_id, :category_id
  validates_associated :state, :category
  
  scope :by_optional_category_id, lambda { |category_id|
    unless category_id.blank?
      type_id = Category.find(category_id).type_id
      joins(:category).where("categories.type_id = ?", type_id)
    end
  }
end
