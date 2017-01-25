class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    string_no_space = @text.delete(" ")

    string_no_newline = string_no_space.delete("\r\n")

    words_array = @text.split

    lowercase = @text.downcase
    lowercase_array = lowercase.split

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = string_no_newline.length

    @word_count = words_array.length

    @occurrences = lowercase_array.count(@special_word)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

     rate = @apr/1200
     months = @years*12

    @monthly_payment = @principal *  (rate + (rate/(((1+rate)**months)-1)))

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================
    difference = @ending-@starting #i assume this is in seconds

    @seconds = difference
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @weeks/52

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @sorted_numbers[0]

    @maximum = @sorted_numbers[-1]

    @range = @maximum-@minimum


    if @count % 2 == 0
      index = (@count)/2
      temp_median = (@sorted_numbers[index] + @sorted_numbers[index-1])/2
    end

    if @count % 2 == 1
      index = (@count+1)/2
      temp_median = @sorted_numbers[index-1]
    end

    @median = temp_median

    temp_sum = 0
    for num in @numbers
      temp_sum += num
    end

    @sum = temp_sum

    @mean = @sum/@count

    var_sum = 0
    @numbers.each do |num|
      var_sum += ((num-@mean) ** 2)
    end

    @variance = var_sum/(@count)

    @standard_deviation = @variance ** 0.5


    freq = @sorted_numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }

    @mode = @sorted_numbers.max_by { |v| freq[v] }

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
