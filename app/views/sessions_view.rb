class SessionsView
  def display(riders)
    riders.each_with_index do |rider, index|
      puts "#{index + 1}. #{rider.username}"
    end
  end

  def ask_for(something)
    puts "#{something}?"
    gets.chomp
  end

  def wrong_password
    puts "Sorrimasen, you're wrong!"
  end
end