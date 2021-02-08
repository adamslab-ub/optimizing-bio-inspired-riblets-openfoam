function [fobj, fcon_eq, fcon_ineq] = objectiveFunction(x, surrogateModelEval)
fobj = surrogateModelEval(x);
fcon_eq = [];
fcon_ineq = [max(6*x(:,3)-x(:,2),0);  max(x(:,2)-6*x(:,1),0); 
			max(x(:,3)-0.6*x(:,1),0)];
end