function b = LoadAssemblerS1D(x,f) % simpson integration
  n = length(x)-1;
  b = zeros(n+1,1);
  for i = 1:n
    h = x(i+1) - x(i);
    b(i)   = b(i)   + (f(x(i))+2*f((x(i+1)+x(i))/2))*h/6; 
  	b(i+1) = b(i+1) + (f(x(i+1))+2*f((x(i+1)+x(i))/2))*h/6;
  end
