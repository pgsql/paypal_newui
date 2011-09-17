class UserChoiceCollection
  attr_accessor :college_choices
  def initialize(initial_choices = [])
    self.college_choices = {}
    initial_choices.each do |college_choice|
      add_choice(college_choice)
    end
  end

  def update_attributes(new_attribute_hash)
    return self if new_attribute_hash.blank?
    new_attribute_hash.each do |key, college_choice|
      find_choice_for_college_id(college_choice[:college_id]).net_cost = college_choice[:net_cost]
    end
    self
  end

  def add_choice(college_choice)
    self.college_choices[college_choice.category.id] ||= {}
    self.college_choices[college_choice.category.id][college_choice.college.id.to_s] = college_choice
  end

  def choice_exists?(college_choice)
    !find_choice_for_college(college_choice.college).nil?
  end

  def find_choice_for_college_id(college_id)
    college_choices.each do |key, choice_category|
      if choice_category[college_id]
        return choice_category[college_id]
      end
    end
    return false
  end

  def for(category)
    if self.college_choices[category.id].respond_to?(:values)
      self.college_choices[category.id].values
    else
      []
    end
  end


end
