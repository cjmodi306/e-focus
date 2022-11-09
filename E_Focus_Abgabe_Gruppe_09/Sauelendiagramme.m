clc;
clear all;

load("Mittelwerte_10.mat");
verbrauch_10 = durchschnittliche_energieverbrauch;
leistung_10 = durchschnittliche_leistung;

load("Mittelwerte_20.mat");
verbrauch_20 = durchschnittliche_energieverbrauch;
leistung_20 = durchschnittliche_leistung;

load("Mittelwerte_30.mat");
verbrauch_30 = durchschnittliche_energieverbrauch;
leistung_30 = durchschnittliche_leistung;

load("Mittelwerte_40.mat");
verbrauch_40 = durchschnittliche_energieverbrauch;
leistung_40 = durchschnittliche_leistung;

load("Mittelwerte_50.mat");
verbrauch_50 = durchschnittliche_energieverbrauch;
leistung_50 = durchschnittliche_leistung;

figure(1);
leistung = [leistung_10,leistung_20, leistung_30,leistung_40,leistung_50];
geschwingkeiten = [10 20 30 40 50];
bar(geschwingkeiten,leistung)
title("mittlere Leistungswerte über Geschwindigkeit", 'FontSize',24)
xlabel('Geschwindigkeiten [km/h]', 'FontSize',24)
ylabel('Mittlere Leistung [kW]', 'FontSize',24)
ylim([0 9])
grid on;

figure(2);
verbrauch = [verbrauch_10, verbrauch_20, verbrauch_30, verbrauch_40, verbrauch_50];
bar(geschwingkeiten,verbrauch)
title("mittlerer Energieverbrauch über Geschwindigkeit", 'FontSize',24)
xlabel('Geschwindigkeiten [km/h]', 'FontSize',24)
ylabel('Mittlerer Verbrauch [kWh/km]','FontSize',24)
grid on;