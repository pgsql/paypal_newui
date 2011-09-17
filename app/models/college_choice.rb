class CollegeChoice
  include ActiveModel::Conversion  
  extend ActiveModel::Naming  
  attr_accessor :user, :college_id, :net_cost, :category_id

  class<<self
    def create_multiple_from_params(params)
      choice_array = []
      params[:college_choice_ids].each do |college_id, choice_boolean|
        if choice_boolean.to_i == 1
          choice_array << new(:college_id => college_id, :category_id => params[:category_id])
        end
      end
      choice_array
    end
  end

  def initialize(params = {})
    params.each do |key, value|
      if self.respond_to?("#{key.to_s}=")
        self.send("#{key.to_s}=", value)
      end
    end
  end

  def college
    College.find(college_id)
  end

  def college=(new_college)
    self.college_id = new_college.id
  end

  def category=(new_category)
    self.category_id = new_category.id
  end

  def category
    Category.find(category_id)
  end


end
