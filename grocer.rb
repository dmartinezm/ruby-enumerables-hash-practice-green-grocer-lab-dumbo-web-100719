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
  coupons.each do |coupon|
    if cart.keys.include? coupon[:item]
      if cart[coupon[:item]][:count] >= coupon[:num]
        new_name = "#{coupon[:item]} W/COUPON"
        if cart[new_name]
          cart[new_name][:count] += coupon[:num]
        else
          cart[new_name] = {
            count: coupon[:num],
            price: coupon[:cost]/coupon[:num],
            clearance: cart[coupon[:item]][:clearance]
          }
        end
        cart[coupon[:item]][:count] -= coupon[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item, description|
   if description[:clearance] == true
     description[:price]=(description[:price]*0.8).round(2)
   end
 end
p cart
end

def checkout(cart, coupons)
  new_cart= consolidate_cart(cart)
  coupon_cart=apply_coupons(new_cart,coupons)
  clearance_cart=apply_clearance(coupon_cart)

  total=0
  clearance_cart.each do |item, description|
    total+= (description[:price]*description[:count])
  end

  total= (total*0.9).round(2) if total> 100
  total
end
