function  val = hatfun(x,xe,k)

	if length(x)<k
		disp('The k is further out then we have points');
		exit(0)
	end
	val = (xe == k);
end

