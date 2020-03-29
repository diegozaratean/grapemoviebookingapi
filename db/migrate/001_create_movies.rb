Sequel.migration do

	up do
		create_table :movies do
			primary_key:id
			String :name, null: false
			String :description
			String :imageurl
			String :begindate
			String :enddate			
		end

	end

	down do
		drop_table :movies
	end
end