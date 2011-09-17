# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# create user admin email = admin@admin.com password = 123456


Role.create :name => 'admin'

PaymentOption.create!(
	[
		{:name => 'Monthly', :duration => 1,:amount => 5}
	]
)

User.create!(
	[
		{:login => 'admin', :login => "admin@example.com",:email => "admin@example.com", :password => "123123", :password_confirmation => "123123", :role_id => Role.find_by_name('admin').id}
	]
)

LoanOption.create(
	[
		{:name => "Option A", :range => "$10,000 = $121 per month", :amount => "10000" },
		{:name => "Option B", :range => "$20,000 = $242 per month", :amount => "20000" },
		{:name => "Option C", :range => "$30,000 = $362 per month", :amount => "30000" },
		{:name => "Option D", :range => "$40,000 = $483 per month", :amount => "40000" }
	]
)

Category.create(
	[
		{:type_id => Category::Flagship, :in_state => true, :name => "Flagship State School (in state)"},
		{:type_id => Category::NonFlagship, :in_state => true, :name => "Non-flagship State School (in state)"},
		{:type_id => Category::Flagship, :in_state => false, :name => "Flagship State School (out of state)"},
		{:type_id => Category::NonFlagship, :in_state => false, :name => "Non-flagship State School (out of state)"},
		{:type_id => Category::HighlySelectivePrivate, :in_state => nil, :name => "Highly Selective Private College"},
		{:type_id => Category::MidSizedPrivate, :in_state => nil, :name => "Mid-size private"},
		{:type_id => Category::Private, :in_state => nil, :name => "Private College"}
	]
)

State.create(
	[
		{:name => "Alabama"},{:name => "Arizona"},{:name => "Arkansas"},{:name => "California"},
		{:name => "Colorado"},{:name => "Connecticut"},{:name => "Delaware"},{:name => "District of Columbia"}, {:name => "Florida"},
		{:name => "Georgia"},{:name => "Hawaii"},{:name => "Idaho"},{:name => "Illinois"},{:name => "Indiana"},
		{:name => "Iowa"},{:name => "Kansas"},{:name => "Kentucky"},{:name => "Lousiana"},{:name => "Maine"},
		{:name => "Maryland"},{:name => "Massachusetts"},{:name => "Michigan"},{:name => "Minessota"},
		{:name => "Mississippi"},{:name => "Missouri"},{:name => "Montana"},{:name => "Nebraska"},
		{:name => "Nevada"},{:name => "New Hampshire"},{:name => "New Jersey"},
		{:name => "New Mexico"},{:name => "North Carolina"},{:name => "North Dakota"},{:name => "Ohio"},{:name => "Oklahoma"},
		{:name => "Oregon"},{:name => "Pennsylvania"},{:name => "Rhode Island"},{:name => "South Carolina"},
		{:name => "South Dakota"},{:name => "Tennesse"},{:name => "Texas"},{:name => "Utah"},{:name => "Vermont"},{:name => "Virginia"},
		{:name => "Washington"},{:name => "West Virginia"},{:name => "Wisconsin"},{:name => "Wyoming"}
	]
)

@state_index = {}
State.all.each do |state|
	@state_index[state.name.downcase.strip] = state.id
end
college_file = File.open(Rails.root + "db/colleges.csv")
i=0
college_file.each do |line|
  i += 1
  puts "Line #{i}"  if i%10 == 0
	college_type_constant, college_name, college_state_name, college_url = line.split(',')
	College.find_or_create_by_name(college_name.strip, {:state_id => @state_index[college_state_name.downcase.strip], :url => college_url.strip, :category_id => Category.find_by_type_id(college_type_constant.constantize).id})
end
