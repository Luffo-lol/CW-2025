function yOut = explicitEulerSecondOrder(lambda, stepSize, y0, dy0, t0, tmax)
    %Used for Q2 part a
    
    %define input
    tVal = t0:stepSize:tmax;
    nSteps = length(tVal);

    %arrays of y and dy
    yOut = zeros(1, nSteps);
    dy = zeros(1, nSteps);

    %set initial values
    yOut(1) = y0;
    dy(1) = dy0;

    %interate for each element of y and dy
    i = 2;
    while i <= nSteps
        yOut(i) = yOut(i - 1) + stepSize * dy(i - 1);
        dy(i) = dy(i - 1) + stepSize * (lambda * yOut(i - 1));
        i = i + 1;
    end
    
