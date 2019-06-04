class Game
  def initialize
    @dictionary = File.readlines('dictionary.txt').map(&:strip).map { |x| x.gsub("'", '') }
    @lives = 10
    @word_to_guess = @dictionary.values_at(rand(@dictionary.size - 1))[0]
    @state = ('*' * @word_to_guess.length).chars
    @wrong_guesses = []
  end

  def action_output
    puts "\nWelcome to hangman game! When game starts you are given 10 lives."
    puts 'You must guess randomly selected word from dictionary letter by letter before you run out of lives'
    puts "Let's start!"
    puts "Your word consists of #{@word_to_guess.length} letters"
    loop do
      check_input
      actions
      puts "Current State: #{@state.join}"
      puts "Wrong guesses: #{@wrong_guesses.join(',')}"
      image
      break if @lives.zero? || @state.join == @word_to_guess
    end
    puts "Congratulations, You won! Indeed, correct word was '#{@word_to_guess}'!"
  end

  def check_input
    loop do
      puts 'Guess the letter!'
      @guess = gets.chomp
      if ('a'..'z').any? { |l| l == @guess }
        if @wrong_guesses.include?(@guess) || @state.include?(@guess)
          puts 'You already tried this letter, try something else!'
        end
        break unless @wrong_guesses.include?(@guess)
      else
        puts 'Your input should be single alphabetical letter!'
      end
    end
  end

  def actions
    unless @state.include?(@guess)
      if @word_to_guess.chars.include?(@guess)
        @word_to_guess.chars.each_with_index do |v, i|
          if v == @guess
            @state.delete_at(i)
            @state.insert(i, @guess)
          end
        end
      else
        @wrong_guesses << @guess
        @lives -= 1
      end
    end
  end

  def image
    case @lives
    when 10
      puts '         '
      puts '        |'
      puts '        |'
      puts '        |'
      puts '        |'
    when 9
      puts '  ______'
      puts '        |'
      puts '        |'
      puts '        |'
      puts '        |'
    when 8
      puts '  ______'
      puts ' |      |'
      puts '        |'
      puts '        |'
      puts '        |'
    when 7
      puts '  ______'
      puts ' |      |'
      puts '(oo)    |'
      puts '        |'
      puts '        |'
    when 6
      puts '  ______'
      puts ' |      |'
      puts '(oo)    |'
      puts ' ||     |'
      puts '        |'
    when 5
      puts '  ______'
      puts ' |      |'
      puts '(oo)    |'
      puts '/||     |'
      puts '        |'
    when 4
      puts '  ______'
      puts ' |      |'
      puts '(oo)    |'
      puts '/||\    |'
      puts '        |'
    when 3
      puts '  ______'
      puts ' |      |'
      puts '(oo)    |'
      puts '/||\    |'
      puts '/       |'
    when 2
      puts '  ______'
      puts ' |      |'
      puts '(oo)    |'
      puts '/||\    |'
      puts '/  \    |'
    when 1
      puts '  ______'
      puts ' |      |'
      puts '(ox)    |'
      puts '/||\    |'
      puts '/  \    |'
    when 0
      puts '  ______'
      puts ' |      |'
      puts '(xx)    |'
      puts '/||\    |'
      puts '/  \    |'
      puts 'Unfortunately you lost! :('
      puts "Word to guess was '#{@word_to_guess}'"
    end
  end
end

u = Game.new
u.action_output
