class Game
 attr_reader :language

 TOTAL_ERRORS_ALLOWED = 7

 def initialize(word, language)
   @letters = word.chars
   @user_guesses = []
   @language = language
 end
 
 def errors
   return @user_guesses - normalized_letters
 end

 def errors_allowed
   return TOTAL_ERRORS_ALLOWED - errors_made
 end

 def errors_made
   return errors.length
 end

 def letters_to_guess
   result = @letters.map do |letter|
     if @user_guesses.include?(normalize_letter(letter))
       letter
     else
       nil
     end
   end 
 end

 def lost?
   return errors_allowed == 0
 end
 
 def over?
   return won? || lost?
 end

 def play!(letter)
   if !over? && !@user_guesses.include?(normalize_letter(letter))
     @user_guesses << normalize_letter(letter)
   end
 end
 
 def won?
   return (normalized_letters - @user_guesses).empty?
 end

 def word
   return @letters.join
 end

 private
 
 def normalize_letter(letter)
   if letter == "Ё"
     return "Е"
   elsif letter == "Й"
     return "И"
   else
     letter
   end
 end

 def normalized_letters
   @letters.map { |letter| normalize_letter(letter) }
 end
end