def consolidate_cart(cart)
  w_cart= Hash.new

 cart.each do |item|
  item.each do |name,description|
    if w_cart[name]
    w_cart[name][:count] +=1
    else
    w_cart[name] = description
    w_cart[name][:count] = 1
    end
  end
  end

w_cart
end

def apply_coupons(cart, coupons)
  return cart if coupons == []
  w_cart= cart

  coupons.each do |coupon|

    name= coupons[:item]
    n_coupons= coupons[:num]
    price= coupons[:cost]

    if cart.include?(name) && cart[name][:count]>= n_coupons
    w_cart[name][:count]-= n_coupons
      if w_cart["#{name} W/COUPON"]
      w_cart["#{name} W/COUPON"][:count] += 1
      else
       w_cart["#{name} W/COUPON"] = {
           :price => coupons[:cost],
           :clearance => w_cart[name][:clearance],
           :count => 1
         }
      end
    end
  end
w_cart
end

def apply_clearance(cart)
  cart.each do |name, description|
    if description[:clearance]
      cart[name][:price]=(cart[name][:price]*0.8).round(2)
    end
  end
cart
end

def checkout(cart, coupons)
  final_cart= consolidate_cart(cart)
  apply_coupons(final_cart,coupons)
  apply_clearance(final_cart)

  total=0
  final_cart.each do |name, description|
    total+= (description[:price]*description[:count])
  end

  if total>=100
   total= (total*0.9).round(2)
  end
   total
end
