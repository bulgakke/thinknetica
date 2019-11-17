require 'rubygems'
require 'telegram/bot'
require_relative 'token'
token = '830311245:AAG4JBbJbEJ1TKUR5leLJ8eOd8ZlrMkGCEM'

puts 'started successfully'
to_sleep = ['firaelmah']
Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    losses = ['проиграл', 'проiграв', 'проигрываю', 'проигрывать']
    yells = ['ору', 'кричу', 'заорал', 'поорал']
    if message.text.class == String
      losses.each { |loss| message.text.include?(loss)}
    end
    bot.api.send_message(chat_id: message.chat.id, reply_to_message_id: message.message_id, text: 'С тобой никто не играл.') if loss_true
    bot.api.send_message(chat_id: message.chat.id, reply_to_message_id: message.message_id, text: 'Не ори.') if yell_true
    if to_sleep.include?(message.from.username) 
      bot.api.send_message(chat_id: message.chat.id, reply_to_message_id: message.message_id, text: '<b>П И З Д У Й 
      С П А Т Ь</b>', parse_mode: "HTML")  unless (5..20) === Time.now.gmtime.hour || message.text.include?('/toggle_sleep')
    end
    if message.text.class != String
    print 'aj'

    elsif message.text == '/toggle_sleep' || message.text == '/toggle_sleep@bulgakkebot'
      if to_sleep.include?(message.from.username)
        to_sleep.delete(message.from.username) unless message.from.username == 'firaelmah'
        bot.api.send_message(chat_id: message.chat.id, text: "You will not be reminded to go to sleep in the evening anymore, #{message.from.first_name}") unless message.from.username == 'firaelmah'
        bot.api.send_message(chat_id: message.chat.id, text: "Для тебя действуют особые условия, даже не пытайся :3") if message.from.username == 'firaelmah'
      else 
        to_sleep << message.from.username 
        bot.api.send_message(chat_id: message.chat.id, text: "You will now be reminded to go to sleep in the evening, #{message.from.first_name}")
      end
    elsif message.text.include?('/greekify')
      input = message.text.downcase.chars
      latin = 'a b c d e f g h i j k l m n o p q r s t u v w x y z'.split' '
      greek = 'α β ς δ ε φ γ η ι ζ κ λ μ η ο π ϙ ρ σ τ υ ν ω χ υ ζ'.split' '
      hash = latin.zip(greek).to_h
      string = ''

      input.each do |letter|
        hash.default = letter
        string += hash[letter]
      end
      string = string.chars
      string.slice!(0..9)
      string = string.join
      bot.api.send_message(chat_id: message.chat.id, text: string) unless string == ''
      bot.api.send_message(chat_id: message.chat.id, text: 'Enter your text after the command, you silly bun...') if string == ''
    elsif message.text.include?('/alternate')
      input = message.text.downcase.chars 
      output = []
      k = 1 
      input.each_index do |i| 
      if input[i].upcase != input[i].downcase 
        output << input[i].upcase if k.odd? 
        output << input[i] if k.even?
        k += 1 
      else output << input[i] 
      end
      end
      output.slice!(0..10)

      bot.api.send_message(chat_id: message.chat.id, text: output.join) unless output.join == ''
      bot.api.send_message(chat_id: message.chat.id, text: 'Enter your text after the command, you silly bun...') if output.join == ''
    elsif message.text == '/start' || message.text == '/start@bulgakkebot'
      bot.api.send_message(chat_id: message.chat.id, text: 'Вечер в палату, пациенты!')

    elsif message.text == '/fuck_me' || message.text == '/fuck_me@bulgakkebot'
       bot.api.send_message(chat_id: message.chat.id, reply_to_message_id: message.message_id, text: "Fuck you, <a href='tg://user?id=#{message.from.id}'>#{CGI::escapeHTML(message.from.first_name)}</a>!", parse_mode: "HTML")
    elsif message.text == '/fuck_them' || message.text == '/fuck_them@bulgakkebot'
      if message.reply_to_message
        bot.api.send_message(chat_id: message.chat.id, reply_to_message_id: message.reply_to_message.message_id, text: "Fuck you, <a href='tg://user?id=#{message.reply_to_message.from.id}'>#{CGI::escapeHTML(message.reply_to_message.from.first_name)}</a>!", parse_mode: "HTML") 
        else bot.api.send_message(chat_id: message.chat.id, text: "Use it as a reply to someone's message") 
        end
    #elsif message.text == '/fuck_him' || message.text == '/fuck_her'
      #if message.reply_to_message
      #fucked = message.reply_to_message.from.username
      #fucker = message.from.username
      #bot.api.send_message(chat_id: message.chat.id, text: "@#{fucked},do you identify with the gender pronoun @#{fucker} used? (Reply to this message with `/yes` or `/no`) ")
      #bot.listen do |message|
        #if message.text.class == String
        #when '/yes'
          #bot.api.send_message(chat_id: message.chat.id, text: 
            #"Fuck you, @#{fucked}!")
          #break
        #when '/no'
          #bot.api.send_message(chat_id: message.chat.id, text: 
            #"Fuck you, @#{fucker}! Stop misgendering people!")
          #break
        #end
        #end
      #else bot.api.send_message(chat_id: message.chat.id, text: "Use it as a reply to someone's message") 
      #end
    elsif message.text == '/are_traps_gay' || message.text == '/are_traps_gay@bulgakkebot'
      bot.api.send_message(chat_id: message.chat.id, text: "Разумеется, нет!") if message.from.username == 'KarinaBauer'
      bot.api.send_message(chat_id: message.chat.id, text: "Ну конечно же да!") if message.from.username != 'KarinaBauer'
    elsif message.text == '/complain' || message.text == '/complain@bulgakkebot'
      bot.api.send_message(chat_id: message.chat.id, text: complaints.sample)

    elsif message.text == '/help' || message.text == '/help@bulgakkebot'
      bot.api.send_message(chat_id: message.chat.id, reply_to_message_id: message.message_id, text: "Эх, да мне бы кто помог...")
    elsif (message.text == '/duel' || message.text == '/duel@bulgakkebot') && !message.reply_to_message 
      bot.api.send_message(chat_id: message.chat.id, reply_to_message_id: message.message_id, text: 'Use it as a reply to someone\'s message.')
    elsif (message.text == '/duel' || message.text == '/duel@bulgakkebot') && message.reply_to_message
      user_id = message.from.id
      user_name = CGI::escapeHTML(message.from.first_name)
      prey_id = message.reply_to_message.from.id
      prey_name = CGI::escapeHTML(message.reply_to_message.from.first_name)
      
      if rand(6) == 0
        result_prey = "U DED, <a href='tg://user?id=#{prey_id}'>#{prey_name}</a>!"
        prey_lost = true
      else
        result_prey = "Everything's fine, <a href='tg://user?id=#{prey_id}'>#{prey_name}</a>, now try again :3"
        prey_winner = "<a href='tg://user?id=#{prey_id}'>#{prey_name}</a> wins! <a href='tg://user?id=#{user_id}'>#{user_name}</a> has to be banned now. "
      end

      if rand(6) == 0
        result_user = "U DED, <a href='tg://user?id=#{user_id}'>#{user_name}</a>!"
        user_lost = true
      else
        result_user = "Everything's fine, <a href='tg://user?id=#{user_id}'>#{user_name}</a>, now try again :3"
        user_winner = "<a href='tg://user?id=#{user_id}'>#{user_name}</a> wins! <a href='tg://user?id=#{prey_id}'>#{prey_name}</a> has to be banned now. "
      end
      double_kill = "<a href='tg://user?id=#{prey_id}'>#{prey_name}</a> and <a href='tg://user?id=#{user_id}'>#{user_name}</a> have just killed each other! Ban both of them!"
      bot.api.send_message(chat_id: message.chat.id, text: result_user, parse_mode: "HTML")
      bot.api.send_message(chat_id: message.chat.id, text: result_prey, parse_mode: "HTML")
      bot.api.send_message(chat_id: message.chat.id, text: user_winner, parse_mode: "HTML") if prey_lost && !user_lost
      bot.api.send_message(chat_id: message.chat.id, text: prey_winner, parse_mode: "HTML") if user_lost && !prey_lost
      bot.api.send_message(chat_id: message.chat.id, text: double_kill, parse_mode: "HTML") if prey_lost && user_lost

    end
  end
end
puts ' '
print 'going down'
=begin


fuck_me - fuck you
fuck_them - fuck them
duel - duels person you reply to with it
complain - complain
toggle_sleep - reminds you to sleep
greekify - greekifies text after 
alternate - alternates case in text after
are_traps_gay - Отвечает на важнейший вопрос 
help - get some help


=end