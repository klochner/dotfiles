IRB.conf[:SAVE_HISTORY] = 500
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_rails_history"

unless defined? ETC_IRBRC_LOADED
  # Require RubyGems by default.
  require 'rubygems'

  # Activate auto-completion.
  require 'irb/completion'

  # Use the simple prompt if possible.
  IRB.conf[:PROMPT_MODE] = :SIMPLE if IRB.conf[:PROMPT_MODE] == :DEFAULT

  # Setup permanent history.
  HISTFILE = "~/.irb_rails_history"
  MAXHISTSIZE = 5000

 def history(num=100)
     h = Readline::HISTORY.to_a
     start = [0,h.size-num-1].max
     h.zip((0..h.size).to_a)[start...h.size].each do |e,i|
       puts " #{(i).to_s.rjust(4)}  #{e}"
  end;nil
 end

 #history grep
 def hg(term)
     num=500
     h = Readline::HISTORY.to_a
     start = [0,h.size-num-1].max
     h.zip((0..h.size).to_a)[start...h.size].each do |e,i|
       puts " #{(i).to_s.rjust(4)}  #{e}" if e =~ /#{term}/
  end;nil
 end

 def timeit(&b)
   t = Time.now
   res = yield
   puts "that took #{Time.now-t}s"
   res
 end

  begin
    histfile = File::expand_path(HISTFILE)
    if File::exists?(histfile)
      lines = IO::readlines(histfile).collect { |line| line.chomp }
      puts "Read #{lines.size} saved history commands from '#{histfile}'." if $VERBOSE
      Readline::HISTORY.push(*lines)
    else
      puts "History file '#{histfile}' was empty or non-existant." if $VERBOSE
    end
    Kernel::at_exit do
      lines = Readline::HISTORY.to_a.reverse.uniq.reverse
      lines = lines[-MAXHISTSIZE, MAXHISTSIZE] if lines.size > MAXHISTSIZE
      puts "Saving #{lines.length} history lines to '#{histfile}'." if $VERBOSE
      File::open(histfile, File::WRONLY|File::CREAT|File::TRUNC) { |io| io.puts lines.join("\n") }
    end
  rescue => e
    puts "Error when configuring permanent history: #{e}" if $VERBOSE
  end

  ETC_IRBRC_LOADED=true
end

