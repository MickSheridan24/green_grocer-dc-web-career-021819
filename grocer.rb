def consolidate_cart(cart)
  # code here
  ret = {}

  cart.each do |e|
    e.each do |k, v|
      if (ret.include? (k))
        ret[k][:count] += 1
      else
        ret[k] = v
        ret[k][:count] = 1
      end
    end
  end
  ret

end

def apply_coupons(cart, coupons)
  # code here :item => "AVO", :count => 2, cost => 5

  coupons.each do |c|
    name = c[:item]
    count = c[:num]
    cost = c[:cost]

    if cart.include? (name)
    orig = cart[name]
    
    
    
    coup_name = "#{name} W/COUPON"
    coup_clear = orig[:clearance]
    if orig[:count] >= count
    if cart.include? (coup_name)
      cart[coup_name][:count] += 1
    else
      cart[coup_name] = {:price => cost, :clearance => coup_clear, :count => 1}
    end
    orig[:count] = orig[:count] - c[:num]
  end
    end
  end
  cart

end

def apply_clearance(cart)
  # code here

  cart.each do |key, value|
    b = value[:clearance]
    if b
      value[:price] = value[:price] - (value[:price] * 0.2)
    end
  end

  cart
end

def checkout(cart, coupons)
  # code here
  cart = consolidate_cart(cart)
  
  
  cart = apply_coupons(cart, coupons)
  
  cart = apply_clearance(cart)
  cost = 0.0
  cart.each do |item, value|
    value[:count].times do
      cost += value[:price]
    end
  end

  if (cost > 100.0)
    cost = cost - (cost * 0.1)
  end
  cost
end

