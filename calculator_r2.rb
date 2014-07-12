#calculator_r2.rb

#<--FUNCTIONS-->:
#1. Simple Arithmetic: +, -, *, /, % - done (r0)
#2. Fractions
#3. Roots: Square, Cube, nth power, and vice versa, square root, cubic root, nth root
#4. Factorial
#5. PI function
#6. Sin, Cos, Tan
#7. Log
#8. Sinh, Cosh, Tanh

#<---FEATURES:--->
#endless loop or exit calculator - done (r1)
#Display formula string - done (r1)
#Verify if input is numeric - done (r2)
#Display as integers or float - partial (r2). Not able to detect if integer or float in subsequent results.
#Return Error in exceptions - ongoing


#<---Check if user input is numeric
class String
  def is_integer?
    true if Integer(self) rescue false
  end
  def is_float?
    true if Float(self) rescue false
  end
end

def num_input()
  num = gets.chomp
  if num.is_integer?
    Integer(num)
  elsif num.is_float?
    Float(num)
  else
    puts "ERROR: Enter a valid number."
    num_input()
  end
end
#--->

#Select Operator/Function
def opfunc_menu()
  puts "Choose an operator/function: 1) +, 2) -, 3) x, 4) /"
  opfuncnum = gets.chomp.to_i
  if opfuncnum >= 1 && opfuncnum <= 4
    opfuncnum
  else
    puts "ERROR: No such operator/function."
    opfunc_menu()
  end
end

#Gateway to various arithmetic methods
def opfunc_direct(opfuncnum, value1, value2)
  if opfuncnum >= 0 && opfuncnum <= 4 
    result = op_simple(opfuncnum, value1, value2)

  else
    puts "ERROR: No such operator/function."
  end 
end

#<---FUNCTIONS METHODS--->
#1. Simple Arithmetic Method
def op_simple(opfuncnum, value1, value2)
  if opfuncnum == 1
    sum = value1 + value2
  elsif opfuncnum == 2
    diff = value1 - value2
  elsif opfuncnum == 3
    product = value1 * value2
  elsif opfuncnum == 4
    if (value1 % value2) == 0 
      remainder = value1 / value2
    else 
      remainder = Float(value1) / Float(value2)
    end
  else
    puts "Error"
  end
end

#<---END FUNCTIONS METHODS--->

#Standardized display of formula and result
def formula_display(opfuncnum, value1, value2, result)
  if opfuncnum == 1
    puts "#{value1} + #{value2} = #{result}"
  elsif opfuncnum == 2
    puts "#{value1} - #{value2} = #{result}"
  elsif opfuncnum == 3
    puts "#{value1} x #{value2} = #{result}"
  elsif opfuncnum == 4
      puts "#{value1} / #{value2} = #{result}"
  else
    puts "ERROR: in formula_display"
  end
end

#To continue or exit calculator
def cont_calc(result1)
  puts "To continue, type 'y'. Otherwise, type 'n':"
  choice = gets.chomp

  if choice == 'y'
    opfuncnum = opfunc_menu()
    puts "Enter another number:"
    num = num_input()
    result2 = opfunc_direct(opfuncnum, result1, num)
    formula_display(opfuncnum, result1, num, result2)
    cont_calc(result2) #recursive

  elsif choice == 'n'
    puts "Exit Calculator.app. Bye!"
  else
    puts "Error"
    cont_calc(result1)
  end
end

#<---MAIN USER INTERFACE--->
puts "Calculator.app (ver2)"
puts "Enter a number:"
num1 = num_input()
opfuncnum1 = opfunc_menu()

puts "Enter another number:"
num2 = num_input()
ans1 = opfunc_direct(opfuncnum1, num1, num2)
puts ans1
formula_display(opfuncnum1, num1, num2, ans1)

cont_calc(ans1)

