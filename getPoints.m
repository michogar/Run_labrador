function points = getPoints(initial, final)
%GETPOINTS get points between two known points
%   Make and interpolation between two points known
    iinitial = initial(1);
    jinitial = initial(2);
    
    ifinal = final(1);
    jfinal = final(2);
    
    if (jfinal-jinitial) < (ifinal-iinitial)
        points = zeros(jfinal-jinitial, 2);
        % calculate setting i
        disp('i');
        for i=iinitial:ifinal
            % get j from i
            points(i, 1)=i;
            points(i, 2)=round((i-iinitial)/(ifinal-iinitial)*(jfinal-jinitial)+jinitial);
        end
    else
        % calculate setting j
        disp('j');
    end
end

