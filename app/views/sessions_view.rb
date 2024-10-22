class SessionsView
  def ask_for(something)
    puts "#{something}?"
    gets.chomp
  end

  def wrong_password
    puts "Sorrimasen, you're wrong!"
  end
end