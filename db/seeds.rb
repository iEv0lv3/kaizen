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
@jordan = User.create!({email: "jordan@turing.io", user_name: "jdawg", password: "jordan1", first_name: "Jordan", last_name: "Williams", cohort: "1811", status: 1})
@steve = User.create!({email: "steve@turing.io", user_name: "sdawg", password: "steve1", first_name: "Steve", last_name: "Anderson", cohort: "1912", status: 0})
@david = User.create!({email: "david@turing.io", user_name: "ddawg", password: "david1", first_name: "David", last_name: "Holtkamp", cohort: "2001", status: 0})
@sebastian = User.create!({email: "sebastian@turing.io", user_name: "seabas", password: "sebastian1", first_name: "Sebastian", last_name: "Sloan", cohort: "1808", status: 1})
@jordan.confirm
@steve.confirm
@david.confirm
@sebastian.confirm

# questions
@question_1 = @steve.questions.create!({subject: "How do I use pride in Ruby?", content: "I am not sure how to get the pretty rainbow dots in my test run?", forum: 0, upvotes: 3})
@question_2 = @david.questions.create!({subject: "How do I make SimpleCov work?", content: "I am so confused, SimpleCov is not working the gem is installed and it is in my test_helper, but it won't work!! someone please help!", forum: 0, upvotes: 1})
@question_3 = @jordan.questions.create!({subject: "I do not know any software developers.", content: "Allison said to get in contact with people you know to make connections in the industry but I don't know any software developers, how am I supposed to do that?", forum: 1, upvotes: 11})
@question_4 = @sebastian.questions.create!({subject: "I am ready for my next job but not sure how to move forward?", content: "I have been at my current job for about 6 months now and I am bored and ready to move on to what I want to do but not sure how to continue?", forum: 1, upvotes: 2})
@question_5 = @steve.questions.create!({subject: "How do you get to the Profile edit page on the Turing Alumn site?", content: "So I have Tried everything!!! I cannot get into the part where I need to update my portfolio?", forum: 1, upvotes: 20})
@question_6 = @jordan.questions.create!({subject: "What was that gem a turing student made that we need?", content: "I remember that there was this super cool gem that we needed for our project, but I can't remember what is was?", forum: 0, upvotes: 7})
@question_7 = @david.questions.create!({subject: "I totally forgot what I have to get done for PD this mod?", content: "So I am a mod 2 student and I cannot remember what I had to get done this mod in PD, anyone know the link to the requirnments?", forum: 1, upvotes: 0})
@question_8 = @sebastian.questions.create!({subject: "So Why do we have to change our routes to resources?", content: "So our routes work, why do we have to change them to resources? I don't get the advantage?", forum: 0, upvotes: 13})
@question_9 = @steve.questions.create!({subject: "Is there anyone who would be willig to practice interviewing with me? ", content: "I suck at interviews, I need someone who can listen to me and give me some tips on how to improve.", forum: 1, upvotes: 8})
@question_10 = @david.questions.create!({subject: "How do you test Oauth in rspec?", content: "So I am lost how to I test that my users can connect to their github account?", forum: 0, upvotes: 15})
@question_11 = @jordan.questions.create!({subject: "So the flower thing in PD?", content: "So I remember this flower and pedal thing in todays PD but honestly, I am lost.", forum: 1, upvotes: 24})
@question_12 = @steve.questions.create!({subject: "How do you get your cart module to access the database?", content: "So I need to get Items into my cart, but My cart isn't part of the database? how do I get it in there?", forum: 0, upvotes: 2})
@question_13 = @sebastian.questions.create!({subject: "Do I need to put the require in my test file or my lib file?", content: "So I have seen people put the require thing at the top of the lib files and their test files is their a proper place to put them?", forum: 0, upvotes: 9})
@question_14 = @david.questions.create!({subject: "Can we start applying for jobs while we are in Turing?", content: "I want to keep applying for jobs to get practice in but are we allowed to do that?", forum: 1, upvotes: 2})
@question_15 = @jordan.questions.create!({subject: "Active record query help", content: "I cannot figure out how to get this query where I need the count of something?", forum: 0, upvotes: 0})
@question_16 = @sebastian.questions.create!({subject: "What is the agile workflow?", content: "What is agile and waterfall workflow and what is the difference between them?", forum: 1, upvotes: 12})

# answers
@answer_1 = @question_1.answers.create!({content: "To get pride to work in ruby you need to put 'require 'minitest/pride' either at the top of all your tests or in your test_helper.", user_id: @jordan.id, upvotes: 9})
@answer_2 = @question_2.answers.create!({content: "It seems like you forgot to put in SimpleCove.start, that is was makes it kick in. just put it right below your 'require 'simplecove'' in your test_helper.", user_id: @sebastian.id, upvotes: 6})
@answer_3 = @question_3.answers.create!({content: "I remember you from my posse meeting! if you want I am going to a meet up this afternoon? want to join? ", user_id: @steve.id, upvotes: 4})
@answer_4 = @question_4.answers.create!({content: "I know some software developers, we all go to a bar and play board games and drink, if you want to join us?", user_id: @david.id, upvotes: 15})
@answer_5 = @question_5.answers.create!({content: "just go to https://turing.io/login then just log into the page.", user_id: @sebastian.id , upvotes: 0})
@answer_6 = @question_5.answers.create!({content: "I had trouble with that as well it is https://turing.io/users", user_id: @jordan.id, upvotes: 6})
@answer_7 = @question_6.answers.create!({content: "The gem your thinking of is shoulda-matchers, you can find it by googleing shoulda-matchers. Make sure to read the README though", user_id: @steve.id, upvotes: 10})
@answer_8 = @question_7.answers.create!({content: "Mostly we are just working on personal sotries and starting a rough draft of how to right a resume but if you go to our mod profession development page there are more details.", user_id: @sebastian.id, upvotes: 4})
@answer_9 = @question_8.answers.create!({content: "I know it is kind of a pain but it is to make the running of the application quicker so the system does not have to go through so many routes to find the right one.", user_id: @david.id, upvotes: 2})
@answer_10 = @question_10.answers.create!({content: "You will need to mock it, I recommend with a VCR, if you go into the mod 3 lessons you should see a lesson on it.", user_id: @jordan.id, upvotes: 13})
@answer_11 = @question_11.answers.create!({content: "I can't quote it but you can find the slides for the lesson on our mod 2 show page.", user_id: @david.id, upvotes: 5})
@answer_12 = @question_12.answers.create!({content: "So your cart module is really a session you need to pull in the data at the model level.", user_id: @jordan.id, upvotes: 0})
@answer_13 = @question_13.answers.create!({content: "There are no real requirnments but I would recommend your test file because it looks cleaner.", user_id: @steve.id, upvotes: 6})
@answer_14 = @question_14.answers.create!({content: "Well yeah you can, the whole point is to get employed ", user_id: @jordan.id, upvotes: 0})
@answer_15 = @question_15.answers.create!({content: "Sure!! We should pair though message me in slack!! ", user_id: @steve.id, upvotes: 1})
@answer_16 = @question_16.answers.create!({content: " The agile work flow is beimg more adaptive and less responsive to a situation", user_id: @david.id, upvotes: 0})
@answer_17 = @question_10.answers.create!({content: "You can mock it without a Vcr to if you DM me on slack we can talk it out?", user_id: @steve.id, upvotes: 0})
@answer_18 = @question_12.answers.create!({content: "Your Cart can be accessed if you pull in the data, I can pair with your tommorow in the T?", user_id: @david.id, upvotes: 0})


# comments
@comment_1 = @question_1.comments.create!({content: "I am confused do you need help building confidence in Ruby or are you wondering about Minitest, pride function?", user_id: @sebastian.id})
@comment_2 = @question_4.comments.create!({content: "Maybe you should wait till you have a full year under your belt before moving? don't want to look like a job hopper", user_id: @jordan.id})
@comment_3 = @answer_2.comments.create!({content: "I am so sorry but I am still a little confused, what is a test_helper? should I have that in futbal?", user_id: @david.id})
@comment_4 = @answer_3.comments.create!({content: "That would be awesome!! Thank you here is my number 303-555-1001", user_id: @david.id})
