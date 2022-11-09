clc;
clear all;

Import_Test_30 = importdata('Test_30.ASC');
Test30 = Import_Test_30.data;

Messzeit = Test30(:,1);
Strom = Test30(:,2);
Spannung = Test30(:,3);
Geschwindigkeit = Test30(:,4);
Messintervall = Test30(:,5);

messfenster = 5706:10562;

Messzeit = Messzeit(messfenster);
Strom = Strom(messfenster);
Spannung = Spannung(messfenster);
Geschwindigkeit = Geschwindigkeit(messfenster);
Messintervall = Messintervall(messfenster);
Messdauer = Messzeit-Messzeit(1);
Messdauer = Messdauer(end);
%Gesamtstrecke berechnen
strecke = cumtrapz(Messzeit, Geschwindigkeit/3600);

%Leistung und Energieverbrauch berechnen
leistung = (Spannung.*Strom)/1000; %Leistung in kW
energie = cumtrapz(Messzeit,leistung)/3600;                 %Energie in kWh

%Mittelwerte
durchschnittliche_gesch = mean(Geschwindigkeit);
durchschnittliche_leistung = mean(leistung);
durchschnittliche_energieverbrauch = durchschnittliche_leistung/durchschnittliche_gesch;

fprintf("Durchschnittliche Geschwindigkeit der Testrunde: %0.4f km/h", durchschnittliche_gesch);
fprintf("\nDurchschnittliche Energieverbrauch der Testrunde: %0.4f kWh/km", durchschnittliche_energieverbrauch);
fprintf("\nDurchschnittliche Leistung der Testrunde: %0.4f kW", durchschnittliche_leistung);
fprintf("\nGesamten Energieverbrauch der Testrunde: %0.4f kWh\n", energie(end));
fprintf("\nDauer der Testrunde: %0.4f s\n", Messdauer);

f1 = figure('DefaultAxesFontSize',24);
yyaxis left;
plot(Messzeit-Messzeit(1),leistung,'b-');
xlim([0 150])
ylim([0 25])
grid on;
ylabel('Leistung [kW] \rightarrow', 'FontSize',24);
yyaxis right;
plot(Messzeit-Messzeit(1), energie,'r-');
ylim([0 0.2])
xlabel('Zeit[s]', 'FontSize',24)
ylabel('Energieverlauf [kWh/km] \rightarrow', 'FontSize',24);
title('Leistungs- und Energieverlauf des Fahrzeugs bei 30 km/h','FontSize',24);
legend('Leistung', 'Energieverbrauch','Location', 'NorthWest')


f2 = figure('DefaultAxesFontSize',24);
yyaxis left
plot(Messzeit-Messzeit(1),Geschwindigkeit,'b-')
xlim([0 150])
ylim([0 35])
ylabel('Geschwindigkeit [km/h] \rightarrow', 'FontSize',24);
grid on;
yyaxis right;
plot(Messzeit-Messzeit(1),strecke,'r-');
title('Geschwindigkeits- und Streckenverlauf des Fahrzeugs bei 30 km/h', 'FontSize',24)
xlabel('Zeit[s]', 'FontSize',24)
ylabel('Strecke[km] \rightarrow', 'FontSize',24)
ylim([0 1.4])
legend('Geschwindigkeit', 'Strecke','Location', 'NorthWest')
save("Mittelwerte_30","durchschnittliche_leistung", "durchschnittliche_energieverbrauch")