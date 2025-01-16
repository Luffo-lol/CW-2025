function yOut = RK4SecondOrder(lambda, stepSize, y0, dy0, t0, tmax)
    %used for Question2 part b

    %define input
    tVal = t0:stepSize:tmax;
    nSteps = length(tVal);

    %arrays for y and dy
    yOut = zeros(1, nSteps);
    dy = zeros(1, nSteps);

    %set initial conditions
    yOut(1) = y0;
    dy(1) = dy0;

    %interate for each element of y and dy
    i = 2;
    while i <= nSteps
        %k1 values
        yk1 = stepSize * dy(i - 1);
        dyk1 = stepSize * lambda * yOut(i-1);

        %k2 values
        yk2 = stepSize * (dy(i - 1) + 0.5 * dyk1);
        dyk2 = stepSize * (lambda * (yOut(i - 1) + 0.5 * yk1));

        %k3 values
        yk3 = stepSize * (dy(i - 1) + 0.5 * dyk2);
        dyk3 = stepSize * (lambda * (yOut(i - 1) + 0.5 * yk2));

        %k4 values
        yk4 = stepSize * (dy(i - 1) + dyk3);
        dyk4 = stepSize * (lambda * (yOut(i - 1) + yk3));

        %new y value
        yOut(i) = yOut(i - 1) + (1/6) * (yk1 + 2 * yk2 + 2 * yk3 + yk4);
        dy(i) = dy(i - 1) + (1/6) * (dyk1 + 2 * dyk2 + 2 * dyk3 + dyk4);

        i = i + 1;
    end