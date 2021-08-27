# OD 20210821 000001

def paddingZero(num, digits)
  (("0" * digits) + num.to_s).last(digits)
end

def order_num_generator(id)
  today = Time.now
  "OD#{today.year}#{today.month}#{today.day}"
end

p paddingZero(3, 4)  # 0003
p order_num_generator(3)
