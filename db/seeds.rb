# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Question.destroy_all
Answer.destroy_all
Comment.destroy_all
User.destroy_all

# users
@user_1 = User.create!({email: "user_1@turing.io", user_name: "user_1", password: "user_1", first_name: "User", last_name: "1", cohort: "1811", status: 1})
@user_2 = User.create!({email: "user_2@turing.io", user_name: "user_2", password: "user_2", first_name: "User", last_name: "2", cohort: "1912", status: 0})
@user_3 = User.create!({email: "user_3@turing.io", user_name: "user_3", password: "user_3", first_name: "User", last_name: "3", cohort: "2001", status: 0})
@user_4 = User.create!({email: "user_4@turing.io", user_name: "user_4", password: "user_4", first_name: "User", last_name: "4", cohort: "1808", status: 1})
@user_1.confirm
@user_2.confirm
@user_3.confirm
@user_4.confirm

# questions
@question_1 = @user_2.questions.create!({subject: "How do I use pride in Ruby?", content: "I am not sure how to get the pretty rainbow dots in my test run?", forum: 0, upvotes: 3})
@question_2 = @user_3.questions.create!({subject: "How do I make SimpleCov work?", content: "I am so confused, SimpleCov is not working the gem is installed and it is in my test_helper, but it won't work!! someone please help!", forum: 0, upvotes: 1})
@question_3 = @user_1.questions.create!({subject: "I do not know any software developers.", content: "Allison said to get in contact with people you know to make connections in the industry but I don't know any software developers, how am I supposed to do that?", forum: 1, upvotes: 11})
@question_4 = @user_4.questions.create!({subject: "I am ready for my next job but not sure how to move forward?", content: "I have been at my current job for about 6 months now and I am bored and ready to move on to what I want to do but not sure how to continue?", forum: 1, upvotes: 2})

# answers
@answer_1 = @question_1.answers.create!({content: "To get pride to work in ruby you need to put 'require 'minitest/prid' either at the top of all your tests or in your test_helper.", user_id: @user_1.id, upvotes: 9})
@answer_2 = @question_2.answers.create!({content: "It seems like you forgot to put in SimpleCove.start, that is was makes it kick in. just put it right below your 'require 'simplecove'' in your test_helper.", user_id: @user_4.id, upvotes: 6})
@answer_3 = @question_3.answers.create!({content: "I remember you from my posse meeting! if you want I am going to a meet up this afternoon? want to join? ", user_id: @user_2.id, upvotes: 4})
@answer_4 = @question_4.answers.create!({content: "I know some software developers, we all go to a bar and play board games and drink, if you want to join us?", user_id: @user_3.id, upvotes: 15})

# comments
@comment_1 = @question_1.comments.create!({content: "I am confused do you need help building confidence in Ruby or are you wondering about Minitest, pride function?", user_id: @user_4.id})
@comment_2 = @question_4.comments.create!({content: "Maybe you should wait till you have a full year under your belt before moving? don't want to look like a job hopper", user_id: @user_1.id})
@comment_3 = @answer_2.comments.create!({content: "I am so sorry but I am still a little confused, what is a test_helper? should I have that in futbal?", user_id: @user_3.id})
@comment_4 = @answer_3.comments.create!({content: "That would be awesome!! Thank you here is my number 303-555-1001", user_id: @user_1.id})
