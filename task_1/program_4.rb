print "Введите коэффициент a "
a = gets.chomp.to_f
print "Введите коэффициент b "
b = gets.chomp.to_f
print "Введите коэффициент c "
c = gets.chomp.to_f


d = b**2 - (4 * a * c)


if d > 0
  square_root = Math.sqrt(d)
  x_1 = (-b + square_root) / (2 * a)
  x_2 = (-b - square_root) / (2 * a)
  puts "Дискриминант равен #{d}, x1 равен #{x_1}, x2 равен #{x_2}"
elsif(d == 0)
  x = -b / (2 * a)
  puts "Дискриминант равен #{d}, корень равен #{x}"
else
  puts "Корней нет"
end