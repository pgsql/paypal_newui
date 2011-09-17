module CollegeChoicesHelper
  def decorate_college_choice_rows(college_choice_hash)
    CollegeChoice.choice_categories.inject([]) do |college_choice_html, choice_category|
      college_choice_html << decorate_choice_category_rows(college_choice_hash[choice_category], choice_category)
      college_choice_html
    end.join(" ").html_safe
  end

  def decorate_choice_category_rows(college_choices_for_category, choice_category )
    if college_choices_for_category.blank?
      return placeholder_row_for_category(choice_category)
    else
      return college_choices_for_category.map { |choice| college_row_for_category(choice, choice_category) }.join(" ")
    end
  end

  def calculate_link_if_url(college)
    if college.url.blank?
      "<small>No Calculator Available</small>".html_safe
    else
      link_to( "Calculate!", college.url, :target => :blank )
    end
  end

  def net_cost_or_text_field(f, choice)
    if choice.net_cost.blank?
      output = []
      f.fields_for("college_#{choice.college_id}", choice) do |c|
        output << c.hidden_field(:category_id)
        output << c.hidden_field(:college_id)
        output << c.text_field(:net_cost)
      end
      return output.join(" ").html_safe
    else
      number_to_currency(choice.net_cost)
    end
  end

end
