class State < ActiveRecord::Base
  has_many :colleges
  default_scope order(:name)
  class<<self
    def build_college_hash(colleges)
      colleges.inject({}) do |college_hash, college|
        if college.state
          college_hash[college.state.name] ||= []
          college_hash[college.state.name] << college
        else
          logger.error "No state found for #{college.inspect}"
        end
        college_hash
      end
    end
  end
end
