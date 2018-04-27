#step1

filename = 'train.csv';
data = csvread(filename);
data(1,:) = [];
x_train = data(:,1);
y_train = data(:,2);
x_train(:,2) = 1;
x_train = [x_train(:,2) , x_train(:,1)];
 
 
#step2 
w = rand(2,1);

#step3
y_plot = (w' * x_train')';

figure(1);
hold on;
scatter(x_train(:,2),y_train);

hold on;
plot(x_train(:,2),y_plot);

#step4
w_direct = inv(x_train' * x_train) * x_train' * y_train;
y_plot = (w_direct' * x_train')';
figure(2)
hold on;
scatter(x_train(:,2),y_train);

hold on;
plot(x_train(:,2),y_plot);


#step5
figure(3);
hold on;
scatter(x_train(:,2),y_train);
for i = 1:2,
  for j = 2 : size(data)(1,1),
    x_ = [1,data(j,1)]';
    y = data(j,2);
    eta = 0.00000001;
    w = w - eta * (w' * x_ - y ) * x_;
    if( mod(j,100) == 0),
      y_plot = (w' * x_train')';
      hold on;
      plot(x_train(:,2),y_plot,"r");
    end,
  end,
end,


#step6

w_final = w;
y_plot = (w_final' * x_train');

figure(4);
hold on;
scatter(x_train(:,2),y_train);
hold on;
plot(x_train(:,2),y_plot);

#step7
filename = 'train.csv';
test = csvread(filename);
test(1,:) = [];
x_test = test(:,1);
y_test = test(:,2);
x_test(:,2) = 1;
x_test = [x_test(:,2) , x_test(:,1)];

y_pred1 = x_test * w;

for_rms = y_pred1 - y_test;
for_rms = for_rms.^2;
rms_for_w_final = sqrt(mean(for_rms))

y_pred2 = x_test * w_direct;
for_rms = y_pred2 - y_test;
for_rms = for_rms.^2;
rms_with_w_direct = sqrt(mean(for_rms))

disp("Double enter to exit ")
fgetl(stdin);

