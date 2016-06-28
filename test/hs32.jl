# HS32 definitions for testing purposes
nvar = 3
ncon = 2
f(x) = (x[1]+3*x[2]+x[3])^2+4*(x[1]-x[2])^2
g(x) = [2*(x[1]+3*x[2]+x[3])+8*(x[1]-x[2]);
        6*(x[1]+3*x[2]+x[3])-8*(x[1]-x[2]);
        2*(x[1]+3*x[2]+x[3])]
H(x;obj_weight=1.0) = obj_weight*[10 -2 2;
                                  -2 26 6;
                                   2  6 2]
c(x) = [1-x[1]-x[2]-x[3];
        6*x[2]+4*x[3]-x[1]^3-3]
J(x) = [-1 -1 -1;
        -3*x[1]^2 6 4]
function W(x,y;obj_weight=1.0)
  # this is how the Hessian will be evaluated in the CUTEst interface
  if obj_weight != 0.0
    return obj_weight * (H(x) + y[2]/obj_weight * [-6*x[1] 0 0;0 0 0;0 0 0])
  end
  return y[2] * [-6*x[1] 0 0;0 0 0;0 0 0]
end
