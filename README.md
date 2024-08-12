![GitHub Repo stars](https://img.shields.io/github/stars/nabilhayet/Restaurant) ![GitHub forks](https://img.shields.io/github/forks/nabilhayet/Restaurant) ![GitHub followers](https://img.shields.io/github/followers/nabilhayet) ![Bitbucket open issues](https://img.shields.io/bitbucket/issues/nabilhayet/Restaurant)                                          
                                        <h1>:jack_o_lantern: OS Simulation :jack_o_lantern: </h1>
                                                      
This project offers a comprehensive demonstration of how an operating system functions. It simulates the creation of various processes and their management in memory and on the hard disk. While it doesn't execute real processes, the system's design and mechanisms provide valuable insights into prioritizing tasks. Exploring the parent-child relationship among processes illustrates the interconnectedness and dependencies within a system. 
<a href="https://www.youtube.com/watch?v=UWaRqHpO8fU&t=2s">Demo</a>

Table of Contents
- [Features](#features)
- [Tech-Stack](#tech-stack)
- [Installing](#installing)
- [Challenges](#challenges)
- [Future-Implementation](#future-implementation)
- [Code-Snippet](#code-snippet)
                               
## Features
<ul>
   <li>Create a process in the system</li>
   <li>Have a CPU to keeep track of current process</li>
  <li>Create Ready-Queue to hold processes waitting to use CPU</li>
  <li>Create Hard-Disk to move processes from CPU</li>
  <li>Create parent-child relationship objects to keep track of different process.</li>
  <li>Edit/Delete a process based on any input</li>
  <li>Create Zombie process</li>
  <li>Display status of any process</li>
  <li>Display status of different memory management</li>
  <li></li>
</ul>

## User Signup 
![signup](https://user-images.githubusercontent.com/33500404/109457096-2ac89100-7a28-11eb-8b43-59f02ad884df.gif)

## Make Reservation
![make_res](https://user-images.githubusercontent.com/33500404/109456292-8265fd00-7a26-11eb-96f8-35cc644b9bd6.gif)

## View Reservation 
![view_reservation](https://user-images.githubusercontent.com/33500404/109456997-f3f27b00-7a27-11eb-8cfe-7816b5dbce14.gif)

## Add Cafe
![add_cafe](https://user-images.githubusercontent.com/33500404/109458180-4fbe0380-7a2a-11eb-84db-92658ebf615a.gif)

## View Cafes
![view_cafes](https://user-images.githubusercontent.com/33500404/109458557-091cd900-7a2b-11eb-985f-263f27203c86.gif)

## Form Validation
![Error_validation](https://user-images.githubusercontent.com/33500404/109458252-6ebc9580-7a2a-11eb-927f-fbbdfdc17d31.gif)


## Tech-Stack
<p>This cli app makes use of the following:</p>

* ruby '2.6.1'
* 'bcrypt', '~> 3.1.7'

## Installing
<ul>
   <li> Clone this repo to your local machine git clone <this-repo-url></li>
  <li> run brew update and brew install ruby to install required dependencies</li>
  <li> run gem install pry</li>
  <li> run ruby main.rb</li>
</ul>
        
## Challenges
<ul>
  <li> Signing up via third party for the user was not working in the beginning with github.So i switched from github to facebook for omni-auth.</li>
  <li> Making sure to prevent a user from accessing other user's info took some time.</li>
  <li> Following restful routes pattern for nested routes was not easy.</li>
  <li> Create a connection between restaurant and food felt like a mountain to climb.</li>
</ul>

## Future-Implementation
<ul>
  <li> Adding nested form to make our app more efficient</li>
  <li> Redesign database to make tables more standard</li>
  <li> Insert images while adding new food</li>
</ul>

## Code-Snippet 

```
def login
 @user = User.new 
end 
```
```
def signin
 @user = User.find_by(email: params[:user][:email])
  if @user && @user.authenticate(params[:user][:password])
   session[:user_id] = @user.id
   redirect_to user_profile_path
  else 
   redirect_to user_login_path 
  end 
end 
```
```

def new 
 if is_logged_in?
  @user = current_user 
  @booking = @user.bookings.build
 else 
  redirect_to user_login_path 
 end 
end 
```
```

def create
 @user = current_user 
 @booking = Booking.new(booking_params)
 if @booking.save
  redirect_to user_booking_path(@user, @booking)
 else
  render :new
 end
end
```



