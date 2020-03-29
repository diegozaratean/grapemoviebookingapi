Sequel.migration do

	up do
		create_table :bookings do
			primary_key:id
			Integer :movieid, null: false
			String :date, null: false
			String :name
		end

	end

	down do
		drop_table :bookings
	end
end