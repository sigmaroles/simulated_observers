function fx = myPF(x, theta)
    fx = theta(3) + (1 - theta(3) - theta(4)) / (1 + exp(-theta(2)*(x - theta(1))));
end