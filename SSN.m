clear all
InputFile=strcat('Zbior2.m')
DANE=load(InputFile)

p=[DANE(1,:);DANE(2,:);DANE(3,:);DANE(4,:)]
t=[DANE(4,:)]

pn1=(2/(max(DANE(1,:))-min(DANE(1,:))))*(DANE(1,:)-min(DANE(1,:)))-1;
pn2=(2/(max(DANE(2,:))-min(DANE(2,:))))*(DANE(2,:)-min(DANE(2,:)))-1;
pn3=(2/(max(DANE(3,:))-min(DANE(3,:))))*(DANE(3,:)-min(DANE(3,:)))-1;
pn4=(2/(max(DANE(4,:))-min(DANE(4,:))))*(DANE(4,:)-min(DANE(4,:)))-1;

tn=(2/(max(DANE(4,:))-min(DANE(4,:))))*(DANE(4,:)-min(DANE(4,:)))-1;

pn=[pn1; pn2; pn3]
liczbaneuronow=18
net=newff(pn, tn, liczbaneuronow, {'logsig', 'purelin'}, 'trainlm')
%net.trainParam.epochs=20000
net=init(net)
%proces uczenia sie sieci
net=train(net,pn,tn)
%po zakonczonym procesie uczenia wagi maja nastepujace wartosci
wafiwejsciowe=net.IW{1,1}
biaswejsciowe=net.b{1}
wagiukryte=net.LW{2,1}
biasyukryte=net.b{2}
%zmienne do symulacji sieci neuronowej
styl=5000
temp=50
vsr=0.9

%macierz wartosci, dla ktorych bedzie sprawdzane zuzycie paliwa
Spr=[styl; temp; vsr]
%skalowanie danych wejściowych do symulacji
pn1spr=(2/(max(DANE(1,:))-min(DANE(1,:))))*(Spr(1,1)-min(DANE(1,:)))-1;
pn2spr=(2/(max(DANE(2,:))-min(DANE(2,:))))*(Spr(2,1)-min(DANE(2,:)))-1;
pn3spr=(2/(max(DANE(3,:))-min(DANE(3,:))))*(Spr(3,1)-min(DANE(3,:)))-1;

Spr1=[pn1spr; pn2spr; pn3spr]
%symulowanie sieci neuronowej macierza spr1 i przepisanie wyniku do
%zmiennej zuzycia
temperatura=sim(net,Spr1)
%skalowanie zmiennej zuzycie z zakresu <-1:1> do pierwotngo
temperatura_spalania=(temperatura+1)*(max(DANE(4,:))-min(DANE(4,:)))*0.5+min(DANE(4,:))