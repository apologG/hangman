if (Gem.win_platform?)
 Encoding.default_external = Encoding.find(Encoding.locale_charmap)
 Encoding.default_internal = __ENCODING__

 [STDIN, STDOUT].each do |io|
   io.set_encoding(Encoding.default_external, Encoding.default_internal)
 end
end

require_relative 'lib/game.rb'
require_relative 'lib/console_interface.rb'

puts "Welcome to the 'Hangman game' / Добро пожаловать в игру 'Виселица'"

language = nil
until language =='ru' || language =='en'
 print 'Choose language / Выберите язык(en/ru): '
 language = gets.strip.downcase
 if language == 'ru'
  puts "Русский язык... один момент пожалуйста"
  sleep 2
  word = File.readlines(__dir__ + '/data/words_ru.txt', encoding: 'UTF-8', chomp: true).sample
 elsif language == 'en'
  puts "English language... one moment please"
  sleep 2
  word = File.readlines(__dir__ + '/data/words_en.txt', encoding: 'UTF-8', chomp: true).sample
 end
end

game = Game.new(word, language)
console_interface = ConsoleInterface.new(game)

until game.over?
 console_interface.print_out
 letter = console_interface.get_input
 game.play!(letter)
end

console_interface.print_out