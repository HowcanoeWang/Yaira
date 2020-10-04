unitX=sample.Units(1,1);
unitY=sample.Units(2,1);
unitZ=sample.Units(3,1);
switch unitX
    case 1
        unitX='MM';
    case 2
        unitX='CM';
    case 3
        unitX='DM';
    case 4
        unitX='M';
    case 5
        unitX='KM';
end
switch unitY
    case 1
        unitY='MM';
    case 2
        unitY='CM';
    case 3
        unitY='DM';
    case 4
        unitY='M';
    case 5
        unitY='KM';
end
switch unitZ
    case 1
        unitZ='MM';
    case 2
        unitZ='CM';
    case 3
        unitZ='DM';
    case 4
        unitZ='M';
    case 5
        unitZ='KM';
end