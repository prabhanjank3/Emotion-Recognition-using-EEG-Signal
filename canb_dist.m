function cd = canb_dist(p,q)
   cd = sum(abs(p - q))./ (abs(p) + abs(q));
 end
