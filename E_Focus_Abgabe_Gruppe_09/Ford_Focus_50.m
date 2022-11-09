clc;
clear all;

Import_Test_50 = importdata('Test_50.ASC');
Test50 = Import_Test_50.data;

Messzeit = Test50(:,1);
Strom = Test50(:,2);
Spannung = Test50(:,3);
Geschwindigkeit = Test50(:,4);
Messintervall = Test50(:,5);

messfenster = 4652:7681;

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
xlim([0 80])
xlabel('Zeit[s]', 'FontSize',24)
ylim([0 45])
grid on;
ylabel('Leistung [kW] \rightarrow', 'FontSize',24);
yyaxis right;
plot(Messzeit-Messzeit(1), energie,'r-');
ylim([0 0.18])
ylabel('Energieverlauf [kWh/km] \rightarrow', 'FontSize',24);
title('Leistungs- und Energieverlauf des Fahrzeugs bei 50 km/h','FontSize',24);
legend('Leistung', 'Energieverbrauch','Location', 'NorthWest')


f2 = figure('DefaultAxesFontSize',24);
yyaxis left
plot(Messzeit-Messzeit(1),Geschwindigkeit,'b-')
xlim([0 80])
ylim([0 60])
ylabel('Geschwindigkeit [km/h] \rightarrow', 'FontSize',24);
grid on;
yyaxis right;
plot(Messzeit-Messzeit(1),strecke,'r-');
title('Geschwindigkeits- und Streckenverlauf des Fahrzeugs bei 50 km/h', 'FontSize',24)
xlabel('Zeit[s]', 'FontSize',24)
ylabel('Strecke[km] \rightarrow', 'FontSize',24)
ylim([0 1.2])
legend('Geschwindigkeit', 'Strecke','Location', 'NorthWest')
save("Mittelwerte_50","durchschnittliche_leistung", "durchschnittliche_energieverbrauch")