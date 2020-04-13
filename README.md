<h1 align=center><a href="https://obscure-journey-59246.herokuapp.com">Kaizen</a></h1>

<p align=center>An internal forum to ask questions and provide answers for students, alumni, and staff of
 the <em>Turing School of Software and Design</em>. The goal of this community is to provide a
welcoming environment for new and learning software developers to gain experience asking
and answering questions, and to provide a living resource of answers for students of all 
levels.</p>

## Scope of Questions and Answers

The initial iteration of this project has two broad categories of questions:

* Technical
  * concepts
  * issues and bugs
  * environment setup
  * any technical question
* Professional
  * career
  * job hunt
  * interivews
  * any professional question
  
  In addition tag(s) are used to define a specific categories in each forum page.
  
  Users are able to leave questions, answers and comments to those questions and answers. 
  only the user who created the post of any kind has the ability to modify said post. 
  
  ## External API Connections
  
   This app consumes both GitHub and Stock overlfow API's. What this means is that a user has the ability from their 
   profile to connect and or sign up for github or stock overflow. connecting their remote accounts to this app. We feel
   the advantage of having a one stop for all your question and answer needs will help students grow and develope at 
   quicker pase to keep up with the high demand of Turing.
   
    * GitHub
    * Stock OverFlow 
    
  ## Setup
  
   For those who wish to see this app for yourself on your local drive please follow these simple instructions.
   
   #### First, Fork and Clone
   
    <img width="1365" alt="Screen Shot 2020-04-13 at 8 37 27 AM" src="https://user-images.githubusercontent.com/51456013/79129254-1d4bdf00-7d62-11ea-93a8-8227aa1405bf.png">
    
   After you have forked your own copy of <em>Kaizen</em> it is time to clone it down to your local computer.
   Please Click on the clone & Download button. We strongly recommend that you use the SSH function when cloning as 
   seen below. 
   
   <img width="1283" alt="Screen Shot 2020-04-13 at 8 40 41 AM" src="https://user-images.githubusercontent.com/51456013/79129494-892e4780-7d62-11ea-83e1-32855501d264.png">
   
   If you click on the button the red arrow is pointing to then it will copy the repository url. 
   
   #### Second lets pull your remote and make a local
   
    Now that you have your own remote copy of <em>Kaizen</em> lets make a local copy that you can mess around with 
    yourself!! 
    
    You will need to choose a place in your computers terminal to keep your personal copy of <em>Kaizen</em>. Once
    you have chosen that space please go ahead and run `git clone <command+v>` this will clone the remote repo that we
    just copied. and pull in your remote copy and make a local copy for you!! it should look like this. 
    
    <img width="867" alt="Screen Shot 2020-04-13 at 8 46 07 AM" src="https://user-images.githubusercontent.com/51456013/79129901-3e60ff80-7d63-11ea-908f-014ff00e5e5c.png">
    
    after you hit `return` to clone this repo to your local then you have your local version! We are almost done! 
    
    #### Finally we need to set up your enviornment
    
     To do this we are going to run a lot of commands. However first we have to make sure you have the proper version of
     ruby set up. <em>Kaizen</em> runs on the programming languages Ruby and Rails so we need to make sure you are set
     up. if you do not have ruby installed please [click here](https://www.ruby-lang.org/en/documentation/installation/).
     
     After your ruby version is installed and ready to go we can finish setting up your local <em>Kaizen</em> app. the 
     next step is run a `bundle install` this is a nifty app that takes all the defined apps in the <em>Kaizen</em> gem 
     file and installs them all at once!! if you do not have bundle simply run `gem install bundler` on your command line
     and you will have it in not time. Once you do please run `bundle install` your page should look like this. 
     
     <img width="405" alt="Screen Shot 2020-04-13 at 8 53 12 AM" src="https://user-images.githubusercontent.com/51456013/79130458-3b1a4380-7d64-11ea-8806-e83a283e19ee.png">
     
     Now we just need to set up the database and you are set to start coding with your new copy of <em>Kaizen</em>
     
     Run these commands in sequence 
     
     * `rake db:create`
     * `rake db:migrate`
     * `rake db:seed`
     
     Once these commands have been run then you just need to make sure everything is working!!! 
     
     run `bundle exec rspec` 
     
     if your screen looks like this then you are good to go!!! 
     
     <img width="1057" alt="Screen Shot 2020-04-13 at 8 57 07 AM" src="https://user-images.githubusercontent.com/51456013/79130783-c72c6b00-7d64-11ea-8978-ce464bccba6f.png">
     
## Comments

 We really enjoyed making <em>KAizen</em> for you to use. if you have any comments questions or concerns please leave a 
 comment below. thank you again and have a great day!! 
 
 
  
