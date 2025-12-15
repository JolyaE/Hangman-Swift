import Swift;
//Start of functions' definitions
func guessWord(guess: String, control: String) -> Bool{ //Bool means boolean, and the arrow specifies the return type
    //a function to easily check if the word that the user entered is correct
    return (guess == control);//returns a boolean
}
func guessLetter(guess: Character, control: String) -> Bool{
    //a function to check if the word contains the entered letter
         for character in control{
         if(guess == character){
             return true;
         } 
     }
     return false; //semicolons are optional
}
func guessedAlready(guess: Character, list: [Character]) -> Bool {
    //checks if the letter has been guessed already
    for character in list{
        if(character == guess){
            return true;
        }
    }
    return false
}
func draw(count: Int) -> String{ //return type is a string
      //prints a depiction of the status of hangman at the time of where there is 'count' attempts left
      if(count == 1){ //in swift, indentations are not as significant as java; curly braces are needed
        return "|Face|" + "\n*.*";
      }
      if(count == 2){
        return "|Face||Head|" + "\n|*.*|";
      }
      if(count == 3){
        return "|Face||Head||Body|" + "\n|*.*|\n |";
      }
      if(count == 4){
        return "|Face||Head||Right Arm|||Body|" + "\n|*.*|\n /|";
        }
      if(count == 5){
        return "|Face||Head||Right Arm||Left Arm||Body|" + "\n|*.*|\n /||\n";
      }
      if(count == 6){
        return "|Face||Head||Right Arm||Left Arm||Body||Right Leg|" + "\n|*.*|\n /||\n  /";
      }
      if(count == 7){
        return "|Face||Head||Right Arm||Left Arm||Body||Right Leg||Left Leg|" + "\n|*.*|\n /||\n  /\\";
      }
      return "Dead";
}
func printWord(word: String, guessedLetters: [Character]) -> String{
    //prints the word with the guessed letters, uses the full word for the parameter
    var result = "";
    for i in 0..<word.count{ //a for loop to go through the list
        let place = word.index(word.startIndex, offsetBy: i);//offset by is the equivalent to the java substring method
        let letter = word[place];//uses let because it doesnt change
        if guessedLetters.contains(letter){//sees if the letter is in the list; whether it was guessed or not
            result  = result + String(letter);//converts the char to a string before returning it
        }
        else{
            result  = result + " _ "//places a blank space where the letters have not been guessed
        }
    }
    return result;
}
//End of functions
//Words will be read in from the list below, it is mostly fruits
//all are singular and lowercase for ease of playing
let list = ["mango", "apple", "rasberry", "strawberry", "guava", "honeydew", "melon", "grape", "cantaloupe", "figs", "cherry", "coconut", "honey", "watermelon", "tangerine", "blackberry", "apricot", "christmas", "papaya", "persimmon", "pinapple", "orange", "banana", "kiwi", "blueberry", "maniac", "plum", "changbin", "divine", "nectarine", "pear"];  
//Start of game/what really runs
print("Welcome to hangman. Most of these words are fruits."); //lets the user know what this even is
print("Please use exclusively lowercase while playing. Enjoy!");//just some instructions
var rounds = 0; //keeps track of the total rounds played
var score = 0; //keeps track of only the rounds that are correct
for w in list{
    //goes through the entire list, each index has its own 'level'
    //each loop iteration is its own isolated level
    var lettersDone = [Character](); //all the letters guessed
    var lettersCorrect = [Character](); //only the correct ones
    print(draw(count: 7));//draws the starting drawing of the hangman
    print(printWord(word: w, guessedLetters: lettersCorrect));
    print("Guess a letter:");//prompts the user to enter their guess
    var i = 7; //initializes the variable as a var not a let so that it is editable from inside the loop 
    while i > 0{
      let guess: String =  readLine()!//takes the guess and stores it for every time
      let g: Character = guess[guess.startIndex];//makes the input a character for ease of use and practice using chars
      if(guessedAlready(guess: g, list: lettersDone) == true){
        //checks if the guess has been made already
        print("Already guessed.")
      }
      else{
        if(guessLetter(guess: g, control: w) == true){
          //a loop for if the guess is right
          lettersDone.append(g); //adds the guess to the list with all the guesses
          lettersCorrect.append(g); //adds the guess to the correct letters pile
          print("That was Correct!");//lets the user know it was right
          print(draw(count: i));//depicts the hangman at the current attempts left
          //i += 1;//neutralizes the i so that the user does not have a decrease in their chances/tries
          print(" ");//just to add space for visual ease of reading
          print(printWord(word: w, guessedLetters: lettersCorrect));//prints the word with the guess
          if !printWord(word: w, guessedLetters: lettersDone).contains("_"){ //checks for the whole word being finished
            i -= i; //terminates the loop
            score = score + 1;//adds to the score
          }
        }
        else{ //if the guess is incorrect
          print("Incorrect"); //lets the user know the guess was wrong
          lettersDone.append(g); //adds it to the list with all the letters
          print(draw(count: i - 1));//draws the hangman with one less guess because the i has not yet been decreased
          print(" ");//just to add space for visual ease of reading
          print(printWord(word: w, guessedLetters: lettersCorrect));//prints the word with the guess
          i -= 1; //this subtracts a try because it was incorrect
        }
    }
    print("Guess the whole word?");//asks the user if they wanna guess the whole word (shocker, who could've guessed)
    if(readLine()! == "yes"){
      print("Go ahead then:");//this promt feels like a threat lowkey, it prob is
      if(guessWord(guess: readLine()!, control: w) == true){
        print("Correct!");
        i = 0; //terminates the loop
        score = score + 1;//adds to the score
      }
      else{
        print("Incorrect.");//just tells the user their guess is wrong
      }
    } 
    else{
      print("Maybe next time.");//this one's just disappointed
    }
    print("Letters guessed:");//will show the letters guessed so there's no duplicates
    for j in lettersDone{
      print(j, terminator: " ");//terminator makes sure all the letters are on the same line
    }  
    print(" ");//just there to separate things
    print("What's your next guess?");//asks the next guess
  }
  print("If you didn't get that right, the word was: " + w); //prints the word in case the user is a loser
  rounds = rounds + 1; //adds one to the rounds played
  print("Play again?");//asks the user if they wanna play again its like
  if(readLine()! == "no"){
    break;//apparently terminates the loop
  }
  else{
    print("Next word!");//bc the user has lots of time, iterates again if they dont say no
    //doesnt look for yes specifically because people sometimes use yes or yeah or yea, but usually use no always
  }
}//the loop is terminated or the list ends
print("Your score is "); 
print(score);
print("out of"); //prints out the score on different lines for visual appeal
print(rounds);
print("Thanks for playing! See you later!");//thanks the user for wasting their time here
