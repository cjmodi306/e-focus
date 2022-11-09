clc;
clear all;

Import_Test_20 = importdata('Test_20.ASC');
Test20 = Import_Test_20.data;

Messzeit = Test20(:,1);
Strom = Test20(:,2);
Spannung = Test20(:,3);
Geschwindigkeit = Test20(:,4);
Messintervall = Test20(:,5);

messfenster = 5937:13154;

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
xlim([0 200])
xlabel('Zeit[s]', 'FontSize',24)
ylim([0 25])
grid on;
ylabel('Leistung [kW] \rightarrow', 'FontSize',24);
yyaxis right;
plot(Messzeit-Messzeit(1), energie,'r-');
ylim([0 0.2])
ylabel('Energieverlauf [kWh/km] \rightarrow', 'FontSize',24);
title('Leistungs- und Energieverlauf des Fahrzeugs bei 20 km/h','FontSize',24);
legend('Leistung', 'Energieverbrauch','Location', 'NorthWest')


f2 = figure('DefaultAxesFontSize',24);
yyaxis left
plot(Messzeit-Messzeit(1),Geschwindigkeit,'b-')
xlim([0 200])
ylim([0 30])
ylabel('Geschwindigkeit [km/h] \rightarrow', 'FontSize',24);
grid on;
yyaxis right;
plot(Messzeit-Messzeit(1),strecke,'r-');
title('Geschwindigkeits- und Streckenverlauf des Fahrzeugs bei 20 km/h', 'FontSize',24)
xlabel('Zeit[s]','FontSize',24)
ylabel('Strecke[km] \rightarrow', 'FontSize',24)
ylim([0 1.2])
legend('Geschwindigkeit', 'Strecke','Location', 'NorthWest')
save("Mittelwerte_20","durchschnittliche_leistung", "durchschnittliche_energieverbrauch")