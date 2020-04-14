# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Question.destroy_all
Answer.destroy_all
Comment.destroy_all

# users
@user_1 = User.create!({email: "user_1@turing.io", password: "user_1", first_name: "User", last_name: "1", cohort: "1811", status: 1})
@user_2 = User.create!({email: "user_2@turing.io", password: "user_2", first_name: "User", last_name: "2", cohort: "1912", status: 0})
@user_3 = User.create!({email: "user_3@turing.io", password: "user_3", first_name: "User", last_name: "3", cohort: "2001", status: 0})
@user_4 = User.create!({email: "user_4@turing.io", password: "user_4", first_name: "User", last_name: "4", cohort: "1808", status: 1})
@user_1.confirm
@user_2.confirm
@user_3.confirm
@user_4.confirm