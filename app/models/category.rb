class Category < ActiveRecord::Base
  has_many :colleges
  Flagship               = 1
  NonFlagship            = 2
  HighlySelectivePrivate = 3
  MidSizedPrivate        = 4
  Private                = 5

  def to_query_for_state_id(state_id)
    param_hash = {}
    param_hash[:category_id] = id
    param_hash[:state_id] = state_id if in_state == true
    param_hash[:outside_state_id] = state_id if in_state == false
    param_hash
  end
end
