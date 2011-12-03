require 'ernie'

module Fog
  # Add two numbers together
  def add(a, b)
    a + b + 10
  end

  def fib(n)
    if n == 0 || n == 1
      1
    else
      fib(n - 1) + fib(n - 2)
    end
  end

  def shadow(x)
    "ruby"
  end

  # Return the given number of bytes
  def bytes(n)
    'x' * n
  end

  # Sleep for +sec+ and then return :ok
  def slow(sec)
    sleep(sec)
    :ok
  end

  # Throw an error
  def error
    raise "abandon hope!"
  end
end

Ernie.expose(:fog, Fog)