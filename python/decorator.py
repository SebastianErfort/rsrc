#!/usr/bin/python3
# From https://python.plainenglish.io/improve-your-code-with-decorators-4fec033b99eb
# > A decorator is a function that takes another function and extends the behavior of the latter
# > function without explicitly modifying it.
def example1():
  def log_result(func):
    def inner(*args):
      res = func(*args)
      print("The result is ", res)
      return res

    return inner

  @log_result
  def sum(a, b):
    return a+b

  @log_result
  def subtract(a, b):
    return a-b

  @log_result
  def get_even_digits():
    return [0, 2, 4, 6, 8]

  l = sum(40,2)
  l = subtract(80,11)
  l = get_even_digits()
  # $ The result is [0, 2, 4, 6, 8]

def example2():
  '''Decorator with argument passed to inner function.'''
  def log_with_name(name):
    def log_result(f):
      def inner(*args, **kwargs):
        res = f(*args, **kwargs)
        print(name + ": " + str(res))
      return inner
    return log_result

  @log_with_name("Sum")
  def sum(a, b):
    return a+b

  @log_with_name("Difference")
  def subtract(a, b):
    return a-b

  s = sum(3, 5)
  # Sum: 8
  d = subtract(8, 3)
  # Difference: 5

def main():
  example1()
  example2()

if __name__ == '__main__':
  main()
