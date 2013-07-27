namespace :db do

	desc "add admin"
	task makeadmin: :environment do
		admin = User.create!(name: "Lakshman Somasundaram", email: "laksh@example.com", password: "foobar", password_confirmation: "foobar", admin: true)
	end
end