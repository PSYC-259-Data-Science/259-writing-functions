#Functions have 4 parts: 
  #a function name (what you call to use the function)
  #an argument list (inputs)
  # a body (where calculations are made)
  #and an return value (output). 
  #The last line is the return unless overriden with the return command

function_name <- function(input1, input2) {
  #THIS IS THE BODY
  a <- input1^2
  b <- input2^2
  sqrt(a + b) #THIS IS THE OUTPUT
}

function_name(3,4) #Yep
function_name(3) #Nope (why not?)
function_name(3, "4") #Nope (why not?)
function_name(3:10, 3:10)

#Some things to notice:
  #Running the function lines creates the function in the environment
  #Calling the function returns only the last value
  #Calling the function without all of the input arguments returns an error
  #a and b are created within the function, and don't exist in our environment
  #Entering vector inputs gives us vector outputs, no addtl coding needed

#None of the names we used were helpful! This would be better
hyp <- function(side_a, side_b) {
  sqrt(side_a^2 + side_b^2) 
}
hyp(3,4)

#Be careful what you name your functions!
#You can overwrite existing functions in R
mean <- function(side_a, side_b) {
  sqrt(side_a^2 + side_b^2) 
}
mean(1,2)
mean <- NULL  
mean(1,2) #Phew

#What if we wanted to return an earlier value rather than the last line?
hyp <- function(side_a, side_b) {
  a <- side_a^2
  b <- side_b^2
  sqrt(a + b) 
  return(a)
}
hyp(3,4)

#How could we return multiple values?
#Let's write it together
