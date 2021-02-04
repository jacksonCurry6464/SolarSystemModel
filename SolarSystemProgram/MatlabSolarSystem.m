%I WILL BEGIN WITH INITIALIZING ALL THE VECTORS I WILL NEED TO COMPUTE
%THE ORBITS OF THE PLANETS (NOTE THAT THE SUN WILL BE 1 IN THE VECTOR
%AND MARS WILL BE NUMBER 4)
numYears = 2;      %Here you can change the number of years the simulation runs for
numDays = numYears*365;  %This calculates the number of days my simulation will run for
G = 6.673*(10^-11);      %Gravitational Constant
xCoords = zeros(1,4);
yCoords = zeros(1,4);
zCoords = zeros(1,4);
xVelocity = zeros(1,4);
yVelocity = zeros(1,4);
zVelocity = zeros(1,4);
planetSizes = zeros(1,4);
planetColors = ['magenta','green','blue','red'];
planetMasses = zeros(1,4);
%disp(accelerationVector)
%ALL OF MY INITIAL VECTORS HAVE BEEN SETUP NOW FILL THEM IN WITH REAL DATA
sunMass = 1.989*(10^30);
planetMasses(1) = 0.33*(10^24);
planetMasses(2) = 4.87*(10^24);
planetMasses(3) = 5.97*(10^24);
planetMasses(4) = 0.642*(10^24);
%planetMasses(5) = 1898*(10^24);
%planetMasses(6) = 568*(10^24);
%planetMasses(7) = 86.8*(10^24);
%planetMasses(8) = 102*(10^24);
%planetMasses(9) = 0.0146*(10^24);
planetSizes(1) = 0.38248*100;               %DOING THESE WITH EARTH's SIZE BEING 1
planetSizes(2) = 0.9488868*100;
planetSizes(3) = 1*100;
planetSizes(4) = 0.53245532*100;
%NOW THE INITIAL POSITIONS WHICH WAS FOUND BY QUERYING JPL HORIZONS
%DATABASE FOR 1 SECOND DATA ON JULY 17th 1998 (WHICH IS THE DAY I WAS
%BORN!)
xCoords(1) = -0.24348234;
xCoords(2) = 0.49723208;
xCoords(3) = 0.417679771;
xCoords(4) = 0.10483805;

yCoords(1) = -0.39012324;
yCoords(2) = 0.52423519;
yCoords(3) = -0.926590759;
yCoords(4) = 1.55674308;

zCoords(1) =-0.00951942;
zCoords(2) =-0.02153919;
zCoords(3) =0.00000435159363;
zCoords(4) = 0.03003589;

%NOW THE VELOCITIES
xVelocity(1) = 0.01818846;
xVelocity(2) = -0.01473748;
xVelocity(3) = 0.0154043985;
xVelocity(4) = -0.01342963;

yVelocity(1) = -0.01355356;
yVelocity(2) = 0.01383308;
yVelocity(3) = 0.00700556885;
yVelocity(4) = 0.00212713;

zVelocity(1) = -0.00277665;
zVelocity(2) = 0.00103965;
zVelocity(3) = 0.0000000248151298;
zVelocity(4) = 0.0003747;




for t = 1:numDays      %THIS WILL BE RUNNING FOR 1 YEAR
    for currPlanet = 1:4        %THIS WILL BE CALCULATING THE NEW POSITIONS TO PLOT FOR EACH OF THE 9 PLANETS
        %UPDATING POSITIONS OF PLANETS ACCORDING TO
        %NEWPOSITION=OLDPOSITION+VELOCITY*TIMESTEP(1)
        xCoords(currPlanet) = xCoords(currPlanet)+xVelocity(currPlanet);
        yCoords(currPlanet) = yCoords(currPlanet)+yVelocity(currPlanet);
        zCoords(currPlanet) = zCoords(currPlanet)+zVelocity(currPlanet);
        
        if currPlanet ==1
            disp(xCoords(currPlanet))
            disp(xVelocity(currPlanet))
        end
        
        %FINDING CURRENT ACCELERATION OF PLANET:
        sumOrbitRadius = xCoords(currPlanet)^2+yCoords(currPlanet)^2+zCoords(currPlanet)^2;
        accelerationVectorDirection = [-xCoords(currPlanet), -yCoords(currPlanet), -zCoords(currPlanet)];
        accelerationVectorDirection = accelerationVectorDirection.*(1/magnitudeOrbitRadius);
        %disp(accelerationVectorDirection)
        magAccel = (G*sunMass)/(magnitudeOrbitRadius^2);    %Note that when finding acceleration the mass of the planet will cancel out!
        
        xAccel =((-2.959*10^-4)*xCoords(currPlanet))/(sumOrbitRadius)^1.5; %This is the acceleration components converted into units of AU/day^2
        yAccel =((-2.959*10^-4)*yCoords(currPlanet))/(sumOrbitRadius)^1.5;
        zAccel =((-2.959*10^-4)*zCoords(currPlanet))/(sumOrbitRadius)^1.5;
        
        %FINALLY UPDATING CURRENT PLANET VELOCITIES
        xVelocity(currPlanet) = xVelocity(currPlanet)+xAccel;
        yVelocity(currPlanet) = yVelocity(currPlanet)+yAccel;
        zVelocity(currPlanet) = zVelocity(currPlanet)+zAccel;
        
    end
    
    %%%%IN HERE I WILL PLOT THE CURRENT STATE OF THE SOLARSYSTEM!
    scatter3(0,0,0,800,'yellow','filled', 'DisplayName','The Sun')          %This is plotting the Sun
    hold on
    scatter3(xCoords(1),yCoords(1),zCoords(1),planetSizes(1),'magenta','filled', 'DisplayName','Mercury')
    scatter3(xCoords(2),yCoords(2),zCoords(2),planetSizes(2),'green','filled', 'DisplayName', 'Venus')
    scatter3(xCoords(3),yCoords(3),zCoords(3),planetSizes(3),'blue','filled', 'DisplayName','Earth')
    scatter3(xCoords(4),yCoords(4),zCoords(4),planetSizes(4),'red','filled', 'DisplayName','Mars')
    %legend
    xlabel('X Axis')
    ylabel('Y Axis')
    zlabel('Z Axis')
    title('My Solarsystem!!')

    xlim([-2,2])
    ylim([-2,2])
    zlim([-2,2]) 
    
    if t>200&&t<350
        view(180,0) 
    end
    if t>350
        view(0,90)
    end
    
    drawnow;
    
    hold off
 
end


