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

    count = 0

    for i in words_array
      if i == @special_word
        count += 1
    end

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = string_no_newline.length

    @word_count = words_array.length

    @occurrences = count

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

    percent = @apr/100

    @monthly_payment = @principal * (percent) / (1-1/(1+(percent))**(@years * 12))

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

    @minimum = sorted_numbers[0]

    @maximum = sorted_numbers[-1]

    @range = @maximum-@minimum

    median_count = 0
    temp_median = 0
    if @numbers.odd?
      median_count = (@numbers.length+1)/2
      temp_median = @sorted_numbers[median_count]
    else
      median_count = (@numbers.length)/2
      temp_median = (@sorted_numbers[median_count] + @sorted_numbers[median_count+1])/2
    end

    @median = temp_median

    temp_sum = 0
    for num in @numbers
      temp_sum += num
    end

    @sum = temp_sum

    @mean = @sum/@count

    var_sum = 0
    for num in @numbers
      var_sum += (num-@mean) ** 2
    end

    @variance = var_sum/(@count-1)

    @standard_deviation = @variance ** 0.5


    latest_mode_and_frequency = [0, 0]
    while @numbers.length > b[1]
      num=@numbers[0]
      count = 0
      for i in @numbers
        if num == i
          count +=1
      end

      if count > b[1]
        b = [@numbers[0], count]
      @numbers.delete(@numbers[0])
    end

    @mode = latest_mode_and_frequency[0]

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
