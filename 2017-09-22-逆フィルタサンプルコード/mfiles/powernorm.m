function output = powernorm(Input)
  M = max(Input);
  output = Input.*(1/M);
end
