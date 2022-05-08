clear all
close all

x_min=0; x_max=1000; 
y_min=0; y_max=1000;
no_points_sp1 = 250; 
no_points_sp2 = 250;

%Cosmetic (pointsize)
psize=8;

%% IC 1
%SP1 and SP2 randomly uniformly distributed.
subplot(1,3,1)
A1_sp1 = rand(no_points_sp1)*(x_max-x_min)+x_min;
A1_sp2 = rand(no_points_sp2)*(x_max-x_min)+x_min;
scatter(A1_sp2(:,1),A1_sp2(:,2),psize,[0.4660 0.6740 0.1880],'filled')
hold on
scatter(A1_sp1(:,1),A1_sp1(:,2),psize,[0.6350 0.0780 0.1840],'filled')
xlim([x_min x_max])
ylim([y_min y_max])
daspect([1 1 1])
xlabel('x_1')
ylabel('x_2')
titlestring = append('Time: ',int2str(0),' \Deltat.' );
title(titlestring) 

%% IC 2
%SP1 randomly distributed within small disks. SP2 randomly uniformly distributed.
subplot(1,3,2)
A2_sp2 = rand(no_points_sp2)*(x_max-x_min)+x_min;
no_blobs=5;
blob_diam=25;
points_per_blob=no_points_sp1/no_blobs;
xrand = [200; 150; 400; 570; 820];%rand(no_blobs,1)*(x_max-x_min)+x_min
yrand = [180; 780; 650; 800; 300];%rand(no_blobs,1)*(y_max-y_min)+y_min;
for i = 1:no_blobs
    x0_sp1=xrand(i); y0_sp1=yrand(i);
    r_sp1_min=0; r_sp1_max=blob_diam;
    r_sp1=rand(points_per_blob,1)*(r_sp1_max-r_sp1_min)+r_sp1_min;
    a_sp1 = 2*pi*rand(points_per_blob,1);
    A2_sp1(points_per_blob*(i-1)+1:points_per_blob*i,1) = x0_sp1 + r_sp1.*cos(a_sp1);
    A2_sp1(points_per_blob*(i-1)+1:points_per_blob*i,2) = y0_sp1 + r_sp1.*sin(a_sp1);
end
scatter(A2_sp2(:,1),A2_sp2(:,2),psize,[0.4660 0.6740 0.1880],'filled')
hold on
scatter(A2_sp1(:,1),A2_sp1(:,2),psize,[0.6350 0.0780 0.1840],'filled')
xlim([x_min x_max])
ylim([y_min y_max])
daspect([1 1 1])
xlabel('x_1')
ylabel('x_2')
titlestring = append('Time: ',int2str(0),' \Deltat.' );
title(titlestring) 

%% IC3
%SP1 and SP2 randomly distributed within small disks.
subplot(1,3,3)
A3_sp1 = rand(no_points_sp1)*(x_max-x_min)+x_min;
no_blobs=5;
points_per_blob=no_points_sp1/no_blobs;
for i = 1:no_blobs
    x0_sp1=xrand(i); y0_sp1=yrand(i);
    r_sp1_min=0; r_sp1_max=blob_diam;
    r_sp1=rand(points_per_blob,1)*(r_sp1_max-r_sp1_min)+r_sp1_min;
    a_sp1 = 2*pi*rand(points_per_blob,1);
    A3_sp1(points_per_blob*(i-1)+1:points_per_blob*i,1) = x0_sp1 + r_sp1.*cos(a_sp1);
    A3_sp1(points_per_blob*(i-1)+1:points_per_blob*i,2) = y0_sp1 + r_sp1.*sin(a_sp1);
end
A3_sp2 = rand(no_points_sp2)*(x_max-x_min)+x_min;
no_blobs=5;
points_per_blob=no_points_sp2/no_blobs;
xrand = [400; 60; 850; 560; 500];%rand(no_blobs,1)*(x_max-x_min)+x_min
yrand = [830; 430; 630; 480; 140];%rand(no_blobs,1)*(y_max-y_min)+y_min;
for i = 1:no_blobs
    x0_sp2=xrand(i); y0_sp2=yrand(i);
    r_sp2_min=0; r_sp2_max=blob_diam;
    r_sp2=rand(points_per_blob,1)*(r_sp2_max-r_sp2_min)+r_sp2_min;
    a_sp2 = 2*pi*rand(points_per_blob,1);
    A3_sp2(points_per_blob*(i-1)+1:points_per_blob*i,1) = x0_sp2 + r_sp2.*cos(a_sp2);
    A3_sp2(points_per_blob*(i-1)+1:points_per_blob*i,2) = y0_sp2 + r_sp2.*sin(a_sp2);
end
scatter(A3_sp2(:,1),A3_sp2(:,2),psize,[0.4660 0.6740 0.1880],'filled')
hold on
scatter(A3_sp1(:,1),A3_sp1(:,2),psize,[0.6350 0.0780 0.1840],'filled')
xlim([x_min x_max])
ylim([y_min y_max])
daspect([1 1 1])
xlabel('x_1')
ylabel('x_2')
titlestring = append('Time: ',int2str(0),' \Deltat.' );%'. Run: ',int2str(nr),'.');
title(titlestring) 

%% Write to files
filename1 = 'ICC1.txt';
filename2 = 'ICC2.txt';
filename3 = 'ICC3.txt';

tempfile1 = fopen(filename1,'w');
tempfile2 = fopen(filename2,'w');
tempfile3 = fopen(filename3,'w');

for p=1:no_points_sp1
    fprintf(tempfile1,'%d %.6f %.6f\n',1,A1_sp1(p,1),A1_sp1(p,2));
    fprintf(tempfile2,'%d %.6f %.6f\n',1,A2_sp1(p,1),A2_sp1(p,2));
    fprintf(tempfile3,'%d %.6f %.6f\n',1,A3_sp1(p,1),A3_sp1(p,2));
end

for p=1:no_points_sp2
    fprintf(tempfile1,'%d %.6f %.6f\n',2,A1_sp2(p,1),A1_sp2(p,2));
    fprintf(tempfile2,'%d %.6f %.6f\n',2,A2_sp2(p,1),A2_sp2(p,2));
    fprintf(tempfile3,'%d %.6f %.6f\n',2,A3_sp2(p,1),A3_sp2(p,2));
end

fclose(tempfile1);
fclose(tempfile2);
fclose(tempfile3);