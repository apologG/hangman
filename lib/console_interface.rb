class  ConsoleInterface
 
 FIGURES =
  Dir[__dir__ + "/../data/figures/*.txt"].
  sort.
  map {|file_name| File.read(file_name)}
 
 def initialize(game)
  @game = game
 end
 
 def print_out
  cls
  if @game.language == 'ru'
   puts <<~END
   Cлово: #{word_to_show}
   #{figure}
   Ошибки(#{@game.errors_made}): #{errors_to_show}
   У вас осталось ошибок: #{@game.errors_allowed}
   END
   if @game.won? 
    puts "Поздравляем! Вы выиграли!"
   elsif @game.lost?
    puts "Вы проиграли, загаданное слово: #{@game.word}"
   end
  else
   puts <<~END
   Word: #{word_to_show}
   #{figure}
   Errors letters(#{@game.errors_made}): #{errors_to_show}
   Errors left: #{@game.errors_allowed}
   END
   if @game.won? 
    puts "Congratulations! You won!"
   elsif @game.lost?
    puts "You've lost, hidden word was: #{@game.word}"
   end
  end
 end

 def figure
   return FIGURES[@game.errors_made]
 end

 def word_to_show
  result =
   @game.letters_to_guess.map do |letter| 
    if letter == nil
     "__"
    else
     letter
    end
   end
  return result.join(" ")
 end

 def errors_to_show
  @game.errors.join(", ")
 end

 def get_input
  if @game.language == 'ru'
   print "Введите следующую букву: "
  else
   print "Enter the next letter: "
  end
  letter = gets.upcase.strip[0]
  return letter
 end

 def cls
  system 'clear' or system 'cls'
 end

end