function J = parse_data()

status = system('sh data_parse.sh');
% Import Data from files
zero = importdata('zero_data.dat');
negative =importdata('2_negative_data.dat');
two = importdata('two_data.dat');
four = importdata('four_data.dat');
six = importdata('six_data.dat');
eight = importdata('eight_data.dat');

% save Design Variables
data.xZero = zero(:,[1,2]);
data.xNeg = negative(:,[1,2]);
data.xTwo = two(:,[1,2]);
data.xFour = four(:,[1,2]);
data.xSix = six(:,[1,2]);
data.xEight = eight(:,[1,2]);

% Save Drag Co-efficient Values
data.yZeroDrag = zero(:,3);
data.yNegDrag = negative(:,3);
data.yTwoDrag = two(:,3);
data.yFourDrag = four(:,3);
data.ySixDrag = six(:,3);
data.yEightDrag = eight(:,3);

% Save Lift Co-efficient Value
data.yZeroLift = zero(:,4);
data.yNegLift = negative(:,4);
data.yTwoLift = two(:,4);
data.yFourLift = four(:,4);
data.ySixLift = six(:,4);
data.yEightLift = eight(:,4);
J = data;
numDate = date();
save(strcat('TSF_',num2str(numDate),'.mat'),'data');
end
